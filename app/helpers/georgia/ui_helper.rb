module Georgia
  module UiHelper

    def avatar_url(user, options={})
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=32&d=mm"
    end

    def icon_tag icon_name, options={}
      options[:class] ||= ''
      options[:class] << "icon-#{icon_name}"
      content_tag :i, nil, options
    end

    def link_to_back
      link_to icon_tag('level-up icon-rotate-270'), :back, class: 'btn-back'
    end

    def button_to_save
      content_tag :button, "#{icon_tag 'ok'} Save".html_safe, type: "submit", class: "btn-save"
    end

  end
end