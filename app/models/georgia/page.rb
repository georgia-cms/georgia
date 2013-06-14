module Georgia
  class Page < ActiveRecord::Base

    include Georgia::Concerns::Contentable
    include Georgia::Concerns::Statusable
    include Georgia::Concerns::Revisionable
    include Georgia::Concerns::Slugable
    include Georgia::Concerns::Taggable
    include Georgia::Concerns::Templatable
    include Georgia::Concerns::Orderable
    include Georgia::Concerns::Indexable

    acts_as_list scope: :parent #override orderable to include scope

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
    has_many :widgets, through: :ui_associations

    scope :not_self, ->(page) {where('georgia_pages.id != ?', page.id)}

  end
end