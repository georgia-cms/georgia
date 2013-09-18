module Georgia
  module UiHelper

    def icon_tag icon_name, options={}
      options[:class] ||= ''
      options[:class] << "icon-#{icon_name}"
      content_tag :i, nil, options
    end

  end
end