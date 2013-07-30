module Georgia
  class EditPageButton

    attr_accessor :view, :instance, :actions

    delegate :icon_tag, :content_tag, :link_to, :controller_name, :url_for, :can?, to: :view, prefix: false

    def initialize view, instance, actions={}
      @view = view
      @instance = (instance.decorated? ? instance.object : instance)
      @actions = actions
    end

    def render
      content_tag 'div', class: 'btn-group' do
        group_button + group_list
      end
    end

    private

    def meta_page
      instance.publisher.meta_page
    end

    def group_button
      link_to(icon_tag('icon-cog'), [:edit, meta_page, instance].compact, class: 'btn btn-inverse') +
      link_to(content_tag('span', '', class: 'caret'), '#', group_button_options)
    end

    def group_list
      html = ""
      html << content_tag(:li, link_to_edit)
      html << EditPageActionList.new(view, instance).render
      content_tag :ul, html.html_safe, class: 'dropdown-menu pull-right'
    end

    def link_to_edit
      link_to "#{icon_tag('icon-pencil')} Edit".html_safe, [:edit, meta_page, instance] if can?(:edit, instance)
    end

    def group_button_options
      { class: 'btn btn-inverse dropdown-toggle', data: {toggle: "dropdown"} }
    end

  end
end