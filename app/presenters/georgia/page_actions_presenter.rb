module Georgia
  class PageActionsPresenter

    attr_accessor :view, :page, :revision, :options

    delegate :icon_tag, :content_tag, :link_to, :controller_name, :url_for, :main_app, :can?, :caret_tag, to: :view

    def initialize view, page, revision, options={}
      @view = view
      @page = (page.decorated? ? page.object : page)
      @revision = (revision.decorated? ? revision.object : revision)
      @options = options
    end

    def to_s
      content_tag :div, class: 'btn-group' do
        link_to("Actions #{caret_tag}".html_safe, '#', role: :button, class: 'btn btn-warning', id: 'page_actions', data: {toggle: 'dropdown', target: '#'}) +
        content_tag(:ul, action_list, class: 'dropdown-menu', role: :menu)
      end
    end

    def action_list
      html = ""
      html << content_tag(:li, link_to_edit) if can?(:edit, page)
      html << content_tag(:li, link_to_settings) if can?(:settings, page)
      html << content_tag(:li, link_to_preview) if can?(:preview, page)
      html << content_tag(:li, link_to_copy) if can?(:copy, page)
      if page.current_revision and page.current_revision.published?
        html << content_tag(:li, link_to_publish) if can?(:publish, page) and !page.published?
        html << content_tag(:li, link_to_unpublish) if can?(:unpublish, page) and page.published?
      end
      html << content_tag(:li, link_to_flush_cache) if can?(:flush_cache, page)
      html << content_tag(:li, link_to_revisions) if can?(:index, Revision)
      html.html_safe
    end

    private

    def link_to_preview
      link_to "#{icon_tag('eye')} Preview".html_safe, [:preview, page, revision], options.reverse_merge(target: '_blank')
    end

    def link_to_settings
      link_to "#{icon_tag('cogs')} Settings".html_safe, [:settings, page], options
    end

    def link_to_edit
      link_to "#{icon_tag('pencil')} Edit".html_safe, [:edit, page], options
    end

    def link_to_settings
      link_to "#{icon_tag('cogs')} Settings".html_safe, [:settings, page], options
    end

    def link_to_copy
      link_to "#{icon_tag('copy')} Copy".html_safe, [:copy, page], options
    end

    def link_to_flush_cache
      link_to "#{icon_tag('fire-extinguisher')} Flush Cache".html_safe, [:flush_cache, page], options.merge(method: :post)
    end

    def link_to_publish
      link_to "#{icon_tag('thumbs-up')} Publish".html_safe, [:publish, page], options
    end

    def link_to_unpublish
      link_to "#{icon_tag('thumbs-down')} Unpublish".html_safe, [:unpublish, page], options.merge(data: {confirm: 'Are you sure?'})
    end

    def link_to_review
      link_to "#{icon_tag('flag')} Ask for Review".html_safe, [:review, page], options
    end

    def link_to_approve
      link_to "#{icon_tag('thumbs-up')} Approve".html_safe, [:approve, page], options
    end

    def link_to_decline
      link_to "#{icon_tag('thumbs-down')} Decline".html_safe, [:decline, page], options
    end

    def link_to_delete
      options = {}
      options[:data] ||= {}
      options[:data][:confirm] = 'Are you sure?'
      options[:method] ||= :delete
      link_to "#{icon_tag('icon-trash')} Delete".html_safe, page, options
    end

    def link_to_revisions
      link_to "#{icon_tag('copy')} Revisions".html_safe, [page, :revisions], options
    end

  end
end