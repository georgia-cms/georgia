module Georgia
	class Widget < ActiveRecord::Base

    include Concerns::Contentable

    has_many :ui_associations, dependent: :destroy
    has_many :ui_sections, through: :ui_associations
    has_many :revisions, through: :ui_associations
    has_many :pages, through: :revisions

    scope :footer, joins(:ui_sections).where(georgia_ui_sections: {name: 'Footer'})
    scope :submenu, joins(:ui_sections).where(georgia_ui_sections: {name: 'Submenu'})
    scope :sidebar, joins(:ui_sections).where(georgia_ui_sections: {name: 'Sidebar'})

    scope :for_page, lambda {|page| joins(:ui_associations).where(georgia_ui_associations: {page_id: page.id})}

    validate :content_presence

    def content_presence
      contents.each do |content|
        errors.add(:base, I18n.t("locales.#{content.locale}") + ' Title is required.') unless content.title.present?
        errors.add(:base, I18n.t("locales.#{content.locale}") + ' Content is required.') unless content.text.present?
      end
    end

    def featured?
      @featured ||= pages.any?
    end

    def featured_count
      @featured_count ||= pages.count
    end

  end
end