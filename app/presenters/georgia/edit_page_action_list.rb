module Georgia
  class EditPageActionList

    attr_accessor :view, :instance, :actions

    delegate :icon_tag, :content_tag, :link_to, :controller_name, :url_for, :can?, to: :view, prefix: false

    def initialize view, instance, actions={}
      @view = view
      @instance = (instance.decorated? ? instance.object : instance)
      @actions = actions
    end

    def render
      html = ""
      html << content_tag(:li, link_to_copy) if instance.copyable? and can?(:copy, instance)
      html << content_tag(:li, link_to_preview) if instance.previewable? and can?(:preview, instance)
      html << content_tag(:li, link_to_approve) if instance.approvable? and can?(:approve, instance)
      html << content_tag(:li, link_to_publish) if instance.publishable? and can?(:publish, instance)
      html << content_tag(:li, link_to_review) if instance.reviewable? and can?(:review, instance)
      html.html_safe
    end

    private

    def meta_page
      @meta_page ||= instance.publisher.meta_page
    end

    def link_to_preview
      link_to "#{icon_tag('icon-eye-open')} Preview".html_safe, instance.preview_url, target: '_blank'
    end

    def link_to_draft
      link_to 'Start a new draft', [:draft, instance]
    end

    def link_to_copy
      link_to "#{icon_tag('icon-copy')} Copy".html_safe, url_for(controller: controller_name, id: model.id, action: :copy)
    end

    def link_to_store
      link_to "#{icon_tag('icon-download')} Store".html_safe, url_for(controller: controller_name, id: model.id, action: :store)
    end

    def link_to_approve
      link_to "#{icon_tag('icon-thumbs-up')} Approve".html_safe, [:approve, meta_page, instance]
    end

    def link_to_publish
      link_to "#{icon_tag('icon-thumbs-up')} Publish".html_safe, url_for(controller: controller_name, id: model.id, action: :publish)
    end

    def link_to_unpublish
      link_to "#{icon_tag('icon-thumbs-down')} Unpublish".html_safe, url_for(controller: controller_name, id: model.id, action: :unpublish), data: {confirm: 'Are you sure?'}
    end

    def link_to_review
      link_to "#{icon_tag('icon-flag')} Ask for Review".html_safe, url_for(controller: controller_name, id: model.id, action: :review)
    end

    def link_to_delete
      options = {}
      options[:data] ||= {}
      options[:data][:confirm] = 'Are you sure?'
      options[:method] ||= :delete
      link_to "#{icon_tag('icon-trash')} Delete".html_safe, url_for(controller: controller_name,id: model.id, action: :show), options
    end

  end
end