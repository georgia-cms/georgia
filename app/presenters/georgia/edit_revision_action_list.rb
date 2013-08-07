module Georgia
  class EditRevisionActionList

    attr_accessor :view, :instance, :actions

    delegate :icon_tag, :content_tag, :link_to, :controller_name, :url_for, :main_app, :can?, to: :view, prefix: false

    def initialize view, instance, actions={}
      @view = view
      @instance = (instance.decorated? ? instance.object : instance)
      @actions = actions
    end

    def render
      html = ""
      # Replaces by looking at revision's available events
      # html << content_tag(:li, link_to_draft) if can?(:copy, instance)
      # html << content_tag(:li, link_to_copy) if can?(:copy, instance)
      html << content_tag(:li, link_to_preview) if can?(:preview, instance)
      # html << content_tag(:li, link_to_approve) if can?(:approve, instance)
      # html << content_tag(:li, link_to_publish) if can?(:publish, instance) and !instance.published?
      # html << content_tag(:li, link_to_unpublish) if can?(:unpublish, instance) and instance.published?
      # html << content_tag(:li, link_to_review) if can?(:review, instance)
      html << content_tag(:li, link_to_delete) if can?(:delete, instance)
      html.html_safe
    end

    private

    def page
      @page ||= instance.revisionable
    end

    def link_to_preview
      link_to "#{icon_tag('icon-eye-open')} Preview".html_safe, url_for_page_action(:preview), target: '_blank'
    end

    def link_to_copy
      link_to "#{icon_tag('icon-copy')} Copy".html_safe, url_for_page_action(:copy)
    end

    def link_to_approve
      link_to "#{icon_tag('icon-thumbs-up')} Approve".html_safe, url_for_action(:approve)
    end

    def link_to_publish
      link_to "#{icon_tag('icon-thumbs-up')} Publish".html_safe, url_for_page_action(:publish)
    end

    def link_to_unpublish
      link_to "#{icon_tag('icon-thumbs-down')} Unpublish".html_safe, url_for_page_action(:unpublish), data: {confirm: 'Are you sure?'}
    end

    def link_to_review
      link_to "#{icon_tag('icon-flag')} Ask for Review".html_safe, url_for_action(:review)
    end

    def link_to_delete
      options = {}
      options[:data] ||= {}
      options[:data][:confirm] = 'Are you sure?'
      options[:method] ||= :delete
      link_to "#{icon_tag('icon-trash')} Delete".html_safe, [page, instance], options
    end

    def url_for_action action
      url_for([action, page, instance])
    end

    def url_for_page_action action
      url_for([action, page])
    end

  end
end