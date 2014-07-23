module Georgia
  class PageActionsPresenter < Presenter

    attr_accessor :page, :revision, :options

    def initialize view, page, revision, options={}
      @page = (page.decorated? ? page.object : page)
      @revision = (revision.decorated? ? revision.object : revision)
      @options = options
      super
    end

    def to_s
      content_tag :div, class: 'dropdown' do
        link_to("Actions #{caret_tag}".html_safe, '#', role: :button, class: 'btn btn-warning', data: {toggle: 'dropdown'}) +
        content_tag(:ul, action_list, class: 'dropdown-menu', role: :menu)
      end
    end

    def action_list
      html = ActiveSupport::SafeBuffer.new
      html << content_tag(:li, link_to_preview) if policy(page).preview?
      html << content_tag(:li, link_to_copy) if policy(page).copy?
      html << content_tag(:li, link_to_revisions) if policy(Georgia::Revision).index?
      html
    end

    private

    def link_to_preview
      link_to "#{icon_tag('eye')} Preview".html_safe, [:preview, page, revision], options.reverse_merge(target: '_blank')
    end

    def link_to_copy
      link_to "#{icon_tag('copy')} Copy".html_safe, [:copy, page], options
    end

    def link_to_revisions
      link_to "#{icon_tag('copy')} Revisions".html_safe, [page, :revisions], options
    end

  end
end