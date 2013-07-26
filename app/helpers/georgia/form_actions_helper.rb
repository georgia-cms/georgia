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

    def link_to_draft(instance, options={})
      return if instance.nil? or instance.new_record?
      if can? :draft, instance
        link_to 'Start a new draft', [:draft, instance.model], options
      end
    end

    def link_to_copy(model, options={})
      return if model.nil? or model.new_record?
      if can? :copy, model
        link_to "#{icon_tag('icon-copy')} Copy".html_safe, url_for(controller: controller_name, id: model.id, action: :copy), options
      end
    end

    def link_to_store(model, options={})
      return if model.nil? or model.new_record?
      if can? :store, model
        link_to "#{icon_tag('icon-download')} Store".html_safe, url_for(controller: controller_name, id: model.id, action: :store), options
      end
    end

    def link_to_publish(model, options={})
      return if model.nil? or model.new_record?
      if can? :publish, model
        link_to "#{icon_tag('icon-thumbs-up')} Publish".html_safe, url_for(controller: controller_name, id: model.id, action: :publish), options
      end
    end

    def link_to_unpublish(model, options={})
      return if model.nil? or model.new_record?
      if can? :unpublish, model
        link_to "#{icon_tag('icon-thumbs-down')} Unpublish".html_safe, url_for(controller: controller_name, id: model.id, action: :unpublish), options
      end
    end

    def link_to_review(model, options={})
      return if model.nil? or model.new_record?
      if can? :review, model
        link_to "#{icon_tag('icon-flag')} Ask for Review".html_safe, url_for(controller: controller_name, id: model.id, action: :review), options
      end
    end

    def link_to_group_details(model, options={})
      return if model.nil? or model.new_record?
      instance = (model.decorated? ? model.object : model)
      if can? :show, instance
        content_tag 'div', class: 'btn-group' do
          link_to_group_details_button(instance) + link_to_group_list(instance, options)
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

  end
end
