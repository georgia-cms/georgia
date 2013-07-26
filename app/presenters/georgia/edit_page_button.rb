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
      html << content_tag('li', group_item_edit) if actions[:edit]
      html << content_tag('li', group_item_preview) if actions[:preview]
      html << content_tag('li', group_item_copy) if actions[:copy]
      html << content_tag('li', group_item_store) if actions[:store]
      html << content_tag('li', group_item_publish) if actions[:publish]
      html << content_tag('li', group_item_unpublish) if actions[:unpublish]
      html << content_tag('li', group_item_review) if actions[:review]
      html << content_tag('li', group_item_delete) if actions[:delete]
      content_tag 'ul', html.html_safe, class: 'dropdown-menu pull-right'
    end

    def group_item_copy
      link_to "#{icon_tag('icon-copy')} Copy".html_safe, url_for(controller: controller_name, id: instance.id, action: :copy)
    end

    def group_item_store
      link_to "#{icon_tag('icon-download')} Store".html_safe, url_for(controller: controller_name, id: instance.id, action: :store)
    end

    def group_item_preview
      link_to("#{icon_tag('icon-eye-open')} Preview".html_safe, instance.preview_url, target: '_blank')
    end

    def group_item_publish
      link_to "#{icon_tag('icon-ok')} Publish".html_safe, [:publish, meta_page, instance]
    end

    def group_item_unpublish
      link_to "#{icon_tag('icon-ban-circle')} Unpublish".html_safe, [:unpublish, meta_page, instance]
    end

    def group_item_edit
      link_to "#{icon_tag('icon-pencil')} Edit".html_safe, [:edit, meta_page, instance]
    end

    def group_item_delete
      link_to "#{icon_tag('icon-trash')} Delete".html_safe, [meta_page, instance], data: {confirm: 'Are you sure?'}, method: :delete
    end

    def group_item_review
      link_to "#{icon_tag('icon-check')} Ask for review".html_safe, [:review, meta_page, instance]
    end

    def group_button_options
      { class: 'btn btn-inverse dropdown-toggle', data: {toggle: "dropdown"} }
    end

  end
end