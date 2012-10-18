module Georgia
  class Link < ActiveRecord::Base

    attr_accessible :menu_id, :page_id, :dropdown

    acts_as_list scope: :menu

    belongs_to :menu
    belongs_to :page

    has_many :contents, as: :contentable, dependent: :destroy
    accepts_nested_attributes_for :contents
    attr_accessible :contents_attributes

    scope :ordered, order('position ASC')
    scope :active, where(active: true)
    scope :inactive, where(active: false)
    default_scope includes(:contents)

    def copy_from_page! page
      page.contents.each do |content|
        contents << Georgia::Content.new(
          locale: content.locale,
          title: content.title,
          text: page.url
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