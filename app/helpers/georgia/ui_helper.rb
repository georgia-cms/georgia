module Georgia
  module UiHelper

    def icon_tag icon_name, options={}
      options[:class] ||= ''
      options[:class] << "icon-#{icon_name}"
      content_tag :i, nil, options
    end

    def link_to_back
      link_to icon_tag('level-up icon-rotate-270'), :back, class: 'btn-back'
    end

    def link_to_close
      link_to "&times;".html_safe, "#", class: 'btn-close js-close'
    end

    def button_to_save
      content_tag :button, "#{icon_tag 'ok'} Save".html_safe, type: "submit", class: "btn-save"
    end

  end
end