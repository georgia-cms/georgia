module Georgia
  class Page < ActiveRecord::Base

    include PublicActivity::Common

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    include Georgia::Concerns::Orderable
    include Georgia::Concerns::Treeable

    # acts_as_list scope: :parent #override Concerns::Orderable to include scope
    acts_as_taggable_on :tags

    paginates_per 20

    scope :not_self, ->(page) {where('georgia_pages.id != ?', page.id)}
    scope :published, -> { where(public: true) }
    scope :from_url, -> (path) { where(url: "/#{path}").includes(current_revision: :contents) }

    validates :slug, format: {with: /\A[a-zA-Z0-9_-]+\z/,
      message: 'can only consist of letters, numbers, dash (-) and underscore (_)'}
      #, uniqueness: {scope: [:ancestry, :type], message: 'has already been taken'}

    has_many :revisions, as: :revisionable, dependent: :destroy
    belongs_to :current_revision, class_name: Georgia::Revision, foreign_key: :revision_id

    before_validation :sanitize_slug
    after_save :update_url

    delegate :title, :text, :excerpt, :keywords, :keyword_list, :image, to: :current_revision, allow_nil: true
    delegate :template, :content, :slides, :widgets, to: :current_revision, allow_nil: true
    delegate :draft?, :review?, :revision?, :published?, to: :current_revision, allow_nil: true

    settings analysis: {
      analyzer: {
        'index_ngram_analyzer'  => {type: 'custom', tokenizer: 'standard', filter: ['standard', 'lowercase', 'my_ngram_filter']},
        'search_analyzer'       => {type: 'custom', tokenizer: 'standard', filter: ['standard', 'lowercase']}
      },
      filter: {
        'my_ngram_filter' => {type: 'nGram', min_gram: 2, max_gram: 10, token_chars: [ "letter", "digit", "whitespace", "punctuation", "symbol" ]}
      }
    } do
      mapping index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'
    end

    def as_indexed_json options={}
      self.as_json(
        only: [:id, :updated_at, :slug, :type, :template],
        methods: [:title, :text, :excerpt, :keyword_list, :tag_list]
      )
    end

    # FIXME: Should not be part of this model
    def draft
      Georgia::Clone.new(self).draft
    end

    # FIXME: Should not be part of this model
    def store
      Georgia::Clone.new(self).store
    end

    # FIXME: Should not be part of this model
    def copy
      Georgia::Clone.new(self).copy
    end

    # FIXME: Should not be part of this model
    def approve_revision revision
      current_revision.store if current_revision
      self.update_attribute(:revision_id, revision.id)
    end

    def publish
      self.update_attribute(:public, true)
    end

    def unpublish
      self.update_attribute(:public, false)
    end

    def public?
      self.public
    end
    alias_method :published?, :public?

    def publish_state
      public? ? 'public' : 'private'
    end

    def cache_key
      [self.url, self.updated_at.to_i].join('/')
    end

    # Must stay public for #update_url on descendants
    def set_url
      self.update_column(:url, '/' + self.ancestry_url)
    end

    class << self

      def search_conditions params
        Georgia::PageSearch.new(params).definition
      end

    end

    protected

    def sanitize_slug
      self.slug ||= ''
      self.slug.to_s.gsub!(/^\/*/, '').gsub!(/\/*$/, '')
    end

    def update_url
      if slug_changed? or ancestry_changed?
        self.set_url
        self.descendants.each(&:set_url) if !self.new_record? and self.has_children?
      end
    end

    def ancestry_url
      (ancestors + [self]).map(&:slug).join('/')
    end

  end
end