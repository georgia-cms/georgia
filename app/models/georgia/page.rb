module Georgia
  class Page < ActiveRecord::Base

    include Concerns::Contentable
    include Concerns::Statusable
    include Concerns::Revisionable
    include Concerns::Slugable
    include Concerns::Taggable
    include Concerns::Templatable
    include Concerns::Orderable

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

    searchable do
      text :title, stored: true do
        contents.map(&:title).join(', ')
      end
      text :excerpt, stored: true do
        contents.map(&:excerpt).join(', ')
      end
      text :text do
        contents.map(&:text).join(', ')
      end
      text :keywords do
        contents.map(&:keyword_list).flatten.join(', ')
      end
      text :tags do
        tag_list.join(', ')
      end
      text :url
      text :template
      text :status_name
      string :type #ensure it's nil so it's not a subtype of Georgia::Page, FIXME!
      string :title
      string :excerpt
      string :text
      string :url
      string :template
      string :status_name
      string :keywords, stored: true, multiple: true do
        contents.map(&:keyword_list).flatten
      end
      string :tag_list, stored: true, multiple: true #Facets (multiple)
      string :tags do #Ordering (single list)
        tag_list.join(', ')
      end
    end

  end
end