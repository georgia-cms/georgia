module Georgia
  class EditMetaPageActionList < EditPageActionList

    private

    def meta_page
      @meta_page ||= instance
    end

    def link_to_draft
      link_to "#{icon_tag('icon-paste')} Start a new Draft".html_safe, url_for_meta_action(:draft)
    end

    def link_to_copy
      link_to "#{icon_tag('icon-copy')} Copy".html_safe, url_for_meta_action(:copy)
    end

    def link_to_delete
      options = {}
      options[:data] ||= {}
      options[:data][:confirm] = 'Are you sure?'
      options[:method] ||= :delete
      link_to "#{icon_tag('icon-trash')} Delete".html_safe, instance, options
    end

  end
end