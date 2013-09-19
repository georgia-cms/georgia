module Georgia
  class EditRevisionActionList

    attr_accessor :view, :instance, :options

    delegate :icon_tag, :content_tag, :link_to, :controller_name, :url_for, :main_app, :can?, to: :view, prefix: false

    def initialize view, instance, options={}
      @view = view
      @instance = (instance.decorated? ? instance.object : instance)
      @options = options
    end

    def render
      html = ""
      html << content_tag(:li, link_to_preview) if can?(:preview, instance)
      html << content_tag(:li, link_to_review) if can?(:review, instance) and instance.state_events.include?(:review)
      html << content_tag(:li, link_to_approve) if can?(:approve, instance) and instance.state_events.include?(:approve)
      html << content_tag(:li, link_to_decline) if can?(:decline, instance) and instance.state_events.include?(:decline)
      html << content_tag(:li, link_to_delete) if can?(:delete, instance)
      html.html_safe
    end

    private

    def page
      @page ||= instance.revisionable
    end

    def link_to_preview
      link_to "#{icon_tag('icon-eye-open')} Preview".html_safe, url_for_action(:preview), target: '_blank'
    end

    def link_to_review
      link_to "#{icon_tag('icon-flag')} Ask for Review".html_safe, url_for_action(:review)
    end

    def link_to_approve
      link_to "#{icon_tag('icon-thumbs-up')} Approve".html_safe, url_for_action(:approve)
    end

    def link_to_decline
      link_to "#{icon_tag('icon-thumbs-down')} Decline".html_safe, url_for_action(:decline)
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

  end
end