module Georgia
  module UiHelper

    def avatar_url(user, options={})
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=32&d=mm"
    end

    def icon_tag icon_name, options={}
      options[:class] ||= ''
      options[:class] << "fa fa-#{icon_name}"
      content_tag :i, nil, options
    end

    def link_to_close text=icon_tag('times'), options={}
      link_to text, "#", options.reverse_merge(class: 'btn-close js-close')
    end

    def link_to_back
      link_to icon_tag('level-up fa-rotate-270'), :back, class: 'btn-back'
    end

    def link_to_delete url, options={}
      link_to "#{icon_tag('trash-o')} Delete".html_safe, url, options.reverse_merge(data: {confirm: 'Are you sure?'}, method: :delete, class: 'btn-delete')
    end

    def button_to_save
      content_tag :button, "#{icon_tag 'check'} Save".html_safe, type: "submit", class: "btn-save"
    end

    def tooltip_tag text, tooltip, options={}
      content_tag(:span, icon_tag('info-circle'), options.reverse_merge(title: tooltip, class: 'js-tooltip', data: {placement: 'right'}))
    end

    def page_tag_list page
      page.tag_list.map do |tag|
        content_tag(:span, "#{tag} #{link_to(icon_tag('times'), '#')}".html_safe, class: 'tag')
      end.join(' ').html_safe
    end

  end
end