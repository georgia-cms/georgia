module Georgia
  module InternationalizationHelper

    def available_locales
      I18n.available_locales
    end

    def link_to_locale html_options={}
      if available_locales.length == 2
        link_to_locale_single html_options
      else
        link_to_locale_list html_options
      end
    end

    def link_to_available_locales
      return unless I18n.available_locales.any?
      links = I18n.available_locales.map do |locale|
        content_tag(:li, link_to(t("georgia.#{locale}"), locale: locale ))
      end
      content_tag(:p, class: 'hint') do
        content_tag(:div, class: 'dropdown') do
          link_to("Change language <span class='caret'></span>".html_safe, '#', class: 'btn btn-warning', data: {toggle: 'dropdown'}, role: :button) +
          content_tag(:ul, links.join('').html_safe, class: 'dropdown-menu', role: 'menu')
        end
      end
    end

    protected

    def link_to_locale_list html_options
      content_tag :ul, html_options do
        available_locales.each do |lang|
          concat(content_tag(:li, link_to(t('locale_name', locale: lang), url_for(params.merge(locale: lang)))))
        end
      end
    end

    def link_to_locale_single html_options
      lang = (available_locales - [current_locale]).first
      link_to t('locale_name', locale: lang), url_for(params.merge(locale: lang)), html_options
    end

  end
end