module Georgia
	class Widget < ActiveRecord::Base

    include Concerns::Contentable

    has_many :ui_associations, dependent: :destroy
    has_many :ui_sections, through: :ui_associations
    has_many :revisions, through: :ui_associations
    has_many :pages, through: :revisions

    scope :footer, joins(:ui_sections).where(georgia_ui_sections: {name: 'Footer'}).uniq
    scope :submenu, joins(:ui_sections).where(georgia_ui_sections: {name: 'Submenu'}).uniq
    scope :sidebar, joins(:ui_sections).where(georgia_ui_sections: {name: 'Sidebar'}).uniq

    validate :content_presence

    def content_presence
      contents.each do |content|
        errors.add(:base, I18n.t("locales.#{content.locale}") + ' Title is required.') unless content.title.present?
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