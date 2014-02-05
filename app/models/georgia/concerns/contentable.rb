require 'active_support/concern'

module Georgia
  module Concerns
    module Contentable
      extend ActiveSupport::Concern

      included do
        has_many :contents, as: :contentable, dependent: :destroy, class_name: Georgia::Content
        accepts_nested_attributes_for :contents
        attr_accessible :contents_attributes

        scope :with_locale, lambda {|locale| joins(:contents).where(georgia_contents: {locale: locale}).uniq}

        def content(locale=nil)
          locale ||= I18n.locale.to_s
          @content ||= contents.select{|c| c.locale == locale}.first || Georgia::Content.new(locale: locale)
        end

				delegate :title, :text, :excerpt, :keywords, :keyword_list, :image, :locale, to: :content
      end

    end
  end
end