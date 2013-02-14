# encoding: UTF-8
module Georgia
  module InternationalizationHelper

    LOCALES_HASH = {en: "English", fr: "Français"}

    def locale_name(locale)
      return "" unless locale
      LOCALES_HASH[locale.to_sym]
    end

    def french?
      current_locale? :fr
    end

    def english?
      current_locale? :en
    end

    def current_locale
      I18n.locale.to_s
    end

    def link_to_locale options={}, html_options={}
      options.symbolize_keys!
      options[:text] ||= english? ? "Français" : "English"
      options[:text] = options[:text].parameterize.humanize if options[:normalized]
      options[:locale] ||= english? ? :fr : :en
      html_options[:hreflang] ||= english? ? :fr : :en

      link_to(options[:text], {locale: options[:locale]}, html_options)
    end

    private

    def current_locale?(locale)
      I18n.locale == locale
    end

  end
end