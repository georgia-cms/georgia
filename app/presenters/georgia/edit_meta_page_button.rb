module Georgia
  class EditMetaPageButton < EditPageButton

    def group_button
      link_to(icon_tag('icon-dashboard'), [:details, instance], class: 'btn btn-inverse') +
      link_to(content_tag('span', '', class: 'caret'), '#', group_button_options)
    end

    def group_item_delete
      link_to "#{icon_tag('icon-trash')} Delete".html_safe, instance, data: {confirm: 'Are you sure?'}, method: :delete if can? :destroy, instance
    end

    def group_item_publish
      link_to "#{icon_tag('icon-ok')} Publish".html_safe, [:publish, instance]
    end

    def group_item_unpublish
      link_to "#{icon_tag('icon-ban-circle')} Unpublish".html_safe, [:unpublish, instance]
    end

  end
end