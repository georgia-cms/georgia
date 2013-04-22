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
      text :url
      text :status_name
      text :template
      text :titles do
        contents.map(&:title).join(', ')
      end
      text :contents do
        contents.map(&:text).join(', ')
      end
      text :excerpts do
        contents.map(&:excerpt).join(', ')
      end
      text :keywords do
        contents.map(&:text).join(', ')
      end
      text :tags do
        tag_list.join(', ')
      end
      string :status_name
      string :template
      string :tag_list, stored: true, multiple: true
    end


    def url options={}
      '/' + localized_slug(options) + ancestry_url
    end

    protected

    def localized_slug options={}
      locale = options[:locale] || I18n.locale.to_s
      (I18n.available_locales.length > 1) ? "#{locale}/" : ''
    end

    def ancestry_url
      (ancestors + [self]).map(&:slug).join('/')
    end

  end
end