module Georgia
  class Page < ActiveRecord::Base

    # has_paper_trail ignore: [:created_at, :updated_at, :updated_by_id]

    acts_as_list scope: :parent

    paginates_per 20

    default_scope includes([:contents, :status])

    attr_accessible :template, :slug, :position, :parent_id, :published_at, :published_by_id

    validates :template, inclusion: {in: Georgia.templates, message: "%{value} is not a valid template" }
    validates :slug, uniqueness: {scope: :parent_id}

    belongs_to :published_by, class_name: Georgia::User

    has_many :contents, as: :contentable, dependent: :destroy
    accepts_nested_attributes_for :contents
    attr_accessible :contents_attributes

    belongs_to :parent, class_name: Page
    has_many :children, class_name: Page, foreign_key: :parent_id, order: :position

    has_many :menu_items, dependent: :destroy

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
     associated_against: { contents: [:title, :text, :excerpt, :keywords] }

    def self.search query
      query.present? ? text_search(query) : scoped
    end

    def wait_for_review
      self.status = Georgia::Status.pending_review.first
      self
    end

    def publish(user)
      self.published_at = Time.now
      self.published_by = user
      self.status = Georgia::Status.published.first
      self
    end

    def unpublish
      self.published_at = nil
      self.published_by = nil
      self.status = Georgia::Status.draft.first
      self
    end

    class << self

      def published
        order('published_at DESC').keep_if(&:published?)
      end

    end

    before_save do
      self.status ||= Status.draft.first
    end

  end
end