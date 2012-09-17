module Georgia
  module FormActionsHelper
    def sortable(column, title = nil)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, {sort: column, direction: direction}, {class: css_class}
    end

    def link_to_preview(object)
      # link_to_function("#{icon_tag('icon-eye-open')} Preview".html_safe, "$(this).closest('form').attr('action', '#{url_for([:preview, object])}').submit()")
    end

    def link_to_publish(model)
      return if model.nil? or model.new_record?
      if can? :publish, model
        link_to "#{icon_tag('icon-thumbs-up')} Publish".html_safe, [:publish, model]
      end
    end

    def link_to_unpublish(model)
      return if model.nil? or model.new_record?
      if can? :unpublish, model
        link_to "#{icon_tag('icon-thumbs-down')} Unpublish".html_safe, [:unpublish, model]
      end
    end

    def link_to_review(model)
      return if model.nil? or model.new_record?
      if can? :ask_for_review, model
        link_to "#{icon_tag('icon-flag')} Ask for Review".html_safe, [:ask_for_review, model]
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

    def link_to_delete(model)
      return if model.nil? or model.new_record?
      if can? :destroy, model
        link_to "#{icon_tag('icon-trash')} Delete".html_safe, [model], data: {confirm: 'Are you sure?'}, method: :delete
      end
    end

    def link_to_remove_fields(name, f, options={})
      f.hidden_field(:_destroy) + link_to_function(name, "FormHelper.remove_fields(this)", options)
    end

    def link_to_remove_slide(name, f, options={})
      return unless f and f.object and !f.object.new_record?
      f.hidden_field(:_destroy) + link_to_function(name, "FormHelper.remove_slide(this)", options)
    end

    def link_to_add_fields(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
        render("shared/" + association.to_s.singularize, f: builder)
      end
      link_to_function(raw("<i class='icon-plus-sign'></i> " + name), "FormHelper.add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: 'btn')
    end

    def link_to_add_fields_row(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
        render("shared/" + association.to_s.singularize, f: builder)
      end
      link_to_function(raw("<i class='icon-plus-sign'></i> " + name), "FormHelper.add_fields_row(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: 'btn')
    end

    protected

    def link_to_group_button(model)
      link_to(icon_tag('icon-cog'), [:edit, model], class: 'btn btn-inverse') +
      link_to(content_tag('span', '', class: 'caret'), '#', class: 'btn btn-inverse dropdown-toggle', data: {toggle: "dropdown"})
    end

    def link_to_group_list(model, options={})
      html = ""
      html << content_tag('li', link_to_group_item_edit(model, options))
      html << content_tag('li', link_to_group_item_publish(model, options)) if options[:publish]
      html << content_tag('li', link_to_group_item_unpublish(model, options)) if options[:publish]
      html << content_tag('li', link_to_group_item_ask_for_review(model, options)) if options[:review]
      html << content_tag('li', link_to_group_item_delete(model, options)) if options[:delete]
      content_tag 'ul', html.html_safe, class: 'dropdown-menu'
    end

    def link_to_group_item_publish(model, options={})
      return unless model
      link_to "#{icon_tag('icon-ok')} Publish".html_safe, [:publish, model] if can? :publish, model
    end

    def link_to_group_item_unpublish(model, options={})
      return unless model
      link_to "#{icon_tag('icon-ban-circle')} Unpublish".html_safe, [:unpublish, model] if can? :unpublish, model
    end

    def link_to_group_item_edit(model, options={})
      return unless model
      link_to "#{icon_tag('icon-pencil')} Edit".html_safe, [:edit, model] if can? :edit, model
    end

    def link_to_group_item_delete(model, options={})
      return unless model
      link_to "#{icon_tag('icon-trash')} Delete".html_safe, [model], data: {confirm: 'Are you sure?'}, method: :delete if can? :destroy, model
    end

    def link_to_group_item_ask_for_review(model, options={})
      return unless model
      link_to "#{icon_tag('icon-check')} Ask for review".html_safe, [:ask_for_review, model] if can? :ask_for_review, model
    end
  end
end