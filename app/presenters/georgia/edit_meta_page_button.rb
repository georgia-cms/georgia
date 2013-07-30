module Georgia
  class EditMetaPageButton < EditPageButton

    def group_list
      html = ""
      html << EditMetaPageActionList.new(view, instance).render
      content_tag 'ul', html.html_safe, class: 'dropdown-menu pull-right'
    end

    def group_button
      link_to(icon_tag('icon-dashboard'), [:details, instance], class: 'btn btn-inverse') +
      link_to(content_tag('span', '', class: 'caret'), '#', group_button_options)
    end

  end
end