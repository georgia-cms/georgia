module Georgia
  class EditPageActionList < EditRevisionActionList

    def to_s
      html = ""
      html << content_tag(:li, link_to_edit) if can?(:draft, instance)
      html << content_tag(:li, link_to_copy) if can?(:copy, instance)
      if instance.current_revision and instance.current_revision.published?
        html << content_tag(:li, link_to_publish) if can?(:publish, instance) and !instance.published?
        html << content_tag(:li, link_to_unpublish) if can?(:unpublish, instance) and instance.published?
      end
      html << content_tag(:li, link_to_flush_cache) if can?(:flush_cache, instance)
      html.html_safe
    end

    private

    def page
      @page ||= instance
    end

    def link_to_edit
      link_to "#{icon_tag('pencil')} Edit".html_safe, url_for_action(:draft), options
    end

    def link_to_settings
      link_to "#{icon_tag('cogs')} Settings".html_safe, url_for_action(:edit), options
    end

    def link_to_copy
      link_to "#{icon_tag('copy')} Copy".html_safe, url_for_action(:copy), options
    end

    def link_to_publish
      link_to "#{icon_tag('thumbs-up')} Publish".html_safe, url_for_action(:publish), options
    end

    def link_to_unpublish
      link_to "#{icon_tag('thumbs-down')} Unpublish".html_safe, url_for_action(:unpublish), options.merge(data: {confirm: 'Are you sure?'})
    end

    def link_to_flush_cache
      link_to "#{icon_tag('fire-extinguisher')} Flush Cache".html_safe, url_for_action(:flush_cache), options.merge(method: :post)
    end

    def link_to_delete
      options = {}
      options[:data] ||= {}
      options[:data][:confirm] = 'Are you sure?'
      options[:method] ||= :delete
      link_to "#{icon_tag('icon-trash')} Delete".html_safe, instance, options
    end

    def url_for_action action
      url_for([action, page])
    end

  end
end