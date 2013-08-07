module Georgia
  class EditPageButton < EditRevisionButton

    def group_list
      html = ""
      html << EditPageActionList.new(view, instance).render
      content_tag 'ul', html.html_safe, class: 'dropdown-menu pull-right'
    end

    def group_button
      link_to(icon_tag('icon-dashboard'), instance, class: 'btn btn-inverse') +
      link_to(content_tag('span', '', class: 'caret'), '#', group_button_options)
    end

  end
end