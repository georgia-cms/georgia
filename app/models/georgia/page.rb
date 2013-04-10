module Georgia
  class Page < ActiveRecord::Base

    include Georgia::Publishable
    include Georgia::Revisionable
    include Georgia::Contentable
    include Georgia::Previewable
    include Georgia::Searchable
    include Georgia::Taggable
    include Georgia::Slugable
    include Georgia::Templatable
    include Georgia::Orderable

    has_ancestry orphan_strategy: :rootify
    attr_accessible :parent_id

    paginates_per 20

    belongs_to :updated_by, class_name: Georgia::User
    belongs_to :created_by, class_name: Georgia::User

    # FIXME: Must be turned into polymorphic to allow associations to other classes such as Kennedy::Post
    has_many :slides, dependent: :destroy
    accepts_nested_attributes_for :slides
    attr_accessible :slides_attributes

    # FIXME: Must be turned into polymorphic to allow associations to other classes such as Kennedy::Post
    has_many :ui_associations, dependent: :destroy
    has_many :ui_sections, through: :ui_associations
    has_many :widgets, through: :ui_associations

    scope :not_self, ->(page) {where('georgia_pages.id != ?', page.id)}

  end
end