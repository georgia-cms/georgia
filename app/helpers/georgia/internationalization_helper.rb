# encoding: UTF-8
module Georgia
  module InternationalizationHelper

    #OPTIMIZE: be aware of the current @page object

    def link_to_locale html_options={}
      if I18n.available_locales.length == 2
        link_to_locale_single html_options
      else
        link_to_locale_list html_options
      end
    end

    protected

    def link_to_locale_list html_options
      content_tag :ul, html_options do
        I18n.available_locales.each do |lang|
          concat(content_tag(:li, link_to(t('locale_name', locale: lang), url_for(params.merge(locale: lang)))))
        end
      end
    end

    def link_to_locale_single html_options
      lang = (I18n.available_locales - [I18n.locale]).first
      link_to t('locale_name', locale: lang), url_for(params.merge(locale: lang)), html_options
    end

  end
end