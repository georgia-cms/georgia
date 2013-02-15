module Georgia
  class Link < ActiveRecord::Base

    include Georgia::Contentable

    attr_accessible :menu_id, :page_id, :dropdown

    acts_as_list scope: :menu

    belongs_to :menu, class_name: Georgia::Menu
    belongs_to :page, class_name: Georgia::Page

    scope :ordered, order('position ASC')
    scope :active, where(active: true)
    scope :inactive, where(active: false)
    default_scope includes(:contents).order(:position)

    def copy_from_page! page
      page.contents.each do |content|
        url_options = (page.contents.length > 1 ? {locale: content.locale} : {})
        contents << Georgia::Content.new(
          locale: content.locale,
          title: content.title,
          text: page.url(url_options)
        )
      end
      self
    end

    class << self

      def activate ids=[]
        return unless ids
        ids.each_with_index do |id, index|
          update_all({active: true, position: index+1}, id: id)
        end
      end

      def deactivate ids=[]
        update_all({active: false}, id: ids)
      end
    end
  end
end