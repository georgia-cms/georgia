module Georgia
  class Page < ActiveRecord::Base

    acts_as_list scope: :parent
    acts_as_tree orphan_strategy: :rootify
    acts_as_revisionable associations: :contents
    belongs_to :current_revision, class_name: ActsAsRevisionable::RevisionRecord, foreign_key: :revision_id

    paginates_per 20

    attr_accessible :template, :slug, :position, :published_at, :published_by_id, :parent_id

    validates :template, inclusion: {in: Georgia.templates, message: "%{value} is not a valid template" }
    validates :slug, format: {with: /^[a-zA-Z0-9_-]+$/, message: 'can only consist of letters, numbers, dash (-) and underscore (_)'}, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    belongs_to :published_by, class_name: Georgia::User
    belongs_to :updated_by, class_name: Georgia::User

    has_many :contents, as: :contentable, dependent: :destroy
    accepts_nested_attributes_for :contents
    attr_accessible :contents_attributes

    has_many :links, dependent: :destroy

    belongs_to :status
    delegate :published?, :draft?, :pending_review?, to: :status

    has_many :slides, dependent: :destroy
    accepts_nested_attributes_for :slides
    attr_accessible :slides_attributes

    has_many :ui_associations, dependent: :destroy
    has_many :ui_sections, through: :ui_associations
    has_many :widgets, through: :ui_associations

    include PgSearch
    pg_search_scope :text_search, using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}},
      against: [:slug, :template],
      associated_against: { contents: [:title, :text, :excerpt, :keywords] }

    default_scope includes(:contents)
    scope :published, joins(:status).where('georgia_statuses' => {name: Georgia::Status::PUBLISHED})
    scope :ordered, order(:position)

    before_save :ensure_status
    before_validation :sanitize_slug

    def self.search query
      query.present? ? text_search(query) : scoped
    end

    def wait_for_review
      self.status = Georgia::Status.pending_review.first
      self
    end

    def publish(user)
      self.published_by = user
      self.status = Georgia::Status.published.first
      self.create_revision! unless new_record?
      self.current_revision = self.last_revision
      self
    end

    def unpublish
      self.published_by = nil
      self.current_revision = nil
      self.status = Georgia::Status.draft.first
      self
    end

    def load_current_revision!
      return self if self.current_revision.blank? or self.current_revision == self.last_revision
      self.class.new().load_raw_attributes! self.current_revision.revision_attributes.symbolize_keys!
    end

    def preview! attributes
      self.load_raw_attributes! attributes
    end

    protected

    def load_raw_attributes! attributes
      attributes.delete(:contents).each do |content|
        self.contents << Georgia::Content.new(content, without_protection: true)
      end
      self.assign_attributes(attributes, without_protection: true)
      self
    end

    def ensure_status
      self.status ||= Status.draft.first
    end

    def sanitize_slug
      self.slug ||= ''
      self.slug.gsub!(/^\/*/, '').gsub!(/\/*$/, '')
    end

  end
end