module Georgia
  module UiHelper

    def icon_tag icon_name, options={}
      options[:class] ||= ''
      options[:class] << icon_name
      content_tag :i, nil, options
    end

    def dummy_image width, height, options={}
      options[:text] ||= 'x'
      options[:bg] ||= 'eee'
      options[:fg] ||= 'fff'
      "http://www.dummyimage.com/#{width}x#{height}/#{options[:bg]}/#{options[:fg]}&text=#{options[:text]}"
    end

  end
end