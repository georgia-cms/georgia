module Georgia
  class Page < ActiveRecord::Base

    include Georgia::Publishable
    include Georgia::Revisionable
    include Georgia::Contentable
    include Georgia::Previewable
    include Georgia::Searchable
    include Georgia::Taggable

    acts_as_list scope: :parent
    attr_accessible :position

    has_ancestry orphan_strategy: :rootify

    paginates_per 20

    attr_accessible :template, :slug, :parent_id

    # TODO: Allow this for migration purposes only!
    attr_accessible :created_at, :updated_at

    validates :template, inclusion: {in: Georgia.templates, message: "%{value} is not a valid template" }
    validates :slug, format: {with: /^[a-zA-Z0-9_-]+$/, message: 'can only consist of letters, numbers, dash (-) and underscore (_)'}, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    belongs_to :updated_by, class_name: Georgia::User
    # belongs_to :created_by, class_name: Georgia::User

    has_many :links, dependent: :destroy

    has_many :slides, dependent: :destroy
    accepts_nested_attributes_for :slides
    attr_accessible :slides_attributes

    has_many :ui_associations, dependent: :destroy
    has_many :ui_sections, through: :ui_associations
    has_many :widgets, through: :ui_associations

    scope :ordered, order(:position)
    scope :not_self, ->(page) {where('georgia_pages.id != ?', page.id)}

    before_validation :sanitize_slug

    protected

    def sanitize_slug
      self.slug ||= ''
      self.slug.gsub!(/^\/*/, '').gsub!(/\/*$/, '')
    end

  end
end