module Georgia
  module FormActionsHelper

    def link_to_preview(page, options={})
      options[:target] = '_blank'
      link_to "#{icon_tag('icon-eye-open')} Preview".html_safe, page.preview_url, options if can? :preview, page
    end

    def link_to_preview_revision(page, revision, options={})
      options[:method] = :post
      options[:target] = '_blank'
      revision ||= page.last_revision
      link_to "#{icon_tag('icon-eye-open')} Preview".html_safe, main_app.preview_page_path(page, page: revision.revision_attributes), options
    end

    def link_to_revert revision
      link_to "#{icon_tag('icon-retweet')} Revert".html_safe, georgia.revert_version_path(revision), method: :post, class: 'btn'
    end

    def link_to_copy(model, options={})
      return if model.nil? or model.new_record?
      if can? :copy, model
        link_to "#{icon_tag('icon-copy')} Copy".html_safe, url_for(controller: controller_name,id: model.id, action: :copy), options
      end
    end

    def link_to_store(model, options={})
      return if model.nil? or model.new_record?
      if can? :store, model
        link_to "#{icon_tag('icon-download')} Store".html_safe, url_for(controller: controller_name,id: model.id, action: :store), options
      end
    end

    def link_to_publish(model, options={})
      return if model.nil? or model.new_record?
      if can? :publish, model
        link_to "#{icon_tag('icon-thumbs-up')} Publish".html_safe, url_for(controller: controller_name,id: model.id, action: :publish), options
      end
    end

    def link_to_unpublish(model, options={})
      return if model.nil? or model.new_record?
      if can? :unpublish, model
        link_to "#{icon_tag('icon-thumbs-down')} Unpublish".html_safe, url_for(controller: controller_name,id: model.id, action: :unpublish), options
      end
    end

    def link_to_review(model, options={})
      return if model.nil? or model.new_record?
      if can? :ask_for_review, model
        link_to "#{icon_tag('icon-flag')} Ask for Review".html_safe, url_for(controller: controller_name,id: model.id, action: :ask_for_review), options
      end
    end

    def link_to_group_edit(model, options={})
      return if model.nil? or model.new_record?
      if can? :edit, model
        content_tag 'div', class: 'btn-group' do
          link_to_group_button(model) + link_to_group_list(model, options)
        end
      end
    end

    def link_to_delete(model, options={})
      return if model.nil? or model.new_record?
      if can? :destroy, model
        options[:data] ||= {}
        options[:data][:confirm] = 'Are you sure?'
        options[:method] ||= :delete
        link_to "#{icon_tag('icon-trash')} Delete".html_safe, url_for(controller: controller_name,id: model.id, action: :show), options
      end
    end

    protected

    def link_to_group_button(model)
      link_to(icon_tag('icon-cog'), url_for(controller: controller_name,id: model.id, action: :edit), class: 'btn btn-inverse') +
      link_to(content_tag('span', '', class: 'caret'), '#', class: 'btn btn-inverse dropdown-toggle', data: {toggle: "dropdown"})
    end

    def link_to_group_list(model, options={})
      html = ""
      html << content_tag('li', link_to_group_item_edit(model, options))
      html << content_tag('li', link_to_group_item_preview(model, options)) if options[:preview]
      html << content_tag('li', link_to_group_item_copy(model, options)) if options[:copy]
      html << content_tag('li', link_to_group_item_store(model, options)) if options[:store]
      html << content_tag('li', link_to_group_item_publish(model, options)) if options[:publish]
      html << content_tag('li', link_to_group_item_unpublish(model, options)) if options[:publish]
      html << content_tag('li', link_to_group_item_ask_for_review(model, options)) if options[:review]
      html << content_tag('li', link_to_group_item_delete(model, options)) if options[:delete]
      content_tag 'ul', html.html_safe, class: 'dropdown-menu pull-right'
    end

    def link_to_group_item_copy(model, options={})
      link_to "#{icon_tag('icon-copy')} Copy".html_safe, url_for(controller: controller_name, id: model.id, action: :copy) if can? :copy, model
    end

    def link_to_group_item_store(model, options={})
      link_to "#{icon_tag('icon-download')} Store".html_safe, url_for(controller: controller_name, id: model.id, action: :store) if can? :store, model
    end

    def link_to_group_item_preview(model, options={})
      options[:target] = '_blank'
      link_to("#{icon_tag('icon-eye-open')} Preview".html_safe, model.preview_url, options) if can? :preview, model
    end

    def link_to_group_item_publish(model, options={})
      link_to "#{icon_tag('icon-ok')} Publish".html_safe, url_for(controller: controller_name, id: model.id, action: :publish) if can? :publish, model
    end

    def link_to_group_item_unpublish(model, options={})
      link_to "#{icon_tag('icon-ban-circle')} Unpublish".html_safe, url_for(controller: controller_name, id: model.id, action: :unpublish) if can? :unpublish, model
    end

    def link_to_group_item_edit(model, options={})
      link_to "#{icon_tag('icon-pencil')} Edit".html_safe, url_for(controller: controller_name, id: model.id, action: :edit) if can? :edit, model
    end

    def link_to_group_item_delete(model, options={})
      link_to "#{icon_tag('icon-trash')} Delete".html_safe, url_for(controller: controller_name, id: model.id, action: :destroy), data: {confirm: 'Are you sure?'}, method: :delete if can? :destroy, model
    end

    def link_to_group_item_ask_for_review(model, options={})
      link_to "#{icon_tag('icon-check')} Ask for review".html_safe, url_for(controller: controller_name, id: model.id, action: :ask_for_review) if can? :ask_for_review, model
    end

  end
end
