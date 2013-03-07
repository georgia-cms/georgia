# encoding: UTF-8
module Georgia
  module InternationalizationHelper

    #FIXME: This is all rubish. It should:
    # - be able to have more than two locales
    # - not have its own language translation as a constant
    # - be aware of the current @page object
    # - most likely be a class, not a helper
    # - treat the home page differently, because of the slug hack 'home' present in the url, i.e. '/en/home'
    # - probably have the default_url, set_locale methods of application_controller in the loop
    # - allow locales to be set by Georgia, not application.rb. Available locales might not mean translatable locales
    # - be omnipresent: views (link_to_locale), controllers (set_locale), but could also have decorators' contents handled and more
    # - replace the use of session for the locale, would be stored in the class object

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
      if options[:symbolized]
        options[:text] = english? ? 'FR' : 'EN'
      else
        options[:text] = english? ? LOCALES_HASH[:fr] : LOCALES_HASH[:en]
      end
      options[:text] = options[:text].parameterize.humanize if options[:normalized]
      options[:locale] ||= english? ? :fr : :en
      html_options[:hreflang] ||= english? ? :fr : :en

      if page = options[:page]
        url = page.url(locale: options[:locale])
      else
        url = url_for(params.merge(locale: options[:locale]))
      end

      link_to(options[:text], url, html_options)
    end

    private

    def current_locale?(locale)
      I18n.locale == locale.to_sym
    end

  end
end