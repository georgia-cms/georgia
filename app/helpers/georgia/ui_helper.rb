module Georgia
  module UiHelper

    def icon_tag icon_name
      content_tag 'i', nil, :class => icon_name
    end

    def dummy_image width, height, options={}
      options[:text] ||= 'x'
      options[:bg] ||= 'eee'
      options[:fg] ||= 'fff'
      "http://www.dummyimage.com/#{width}x#{height}/#{options[:bg]}/#{options[:fg]}&text=#{options[:text]}"
    end

    def link_to_remove_fields(name, f)
      f.hidden_field(:_destroy) + link_to_function(name, "FormHelper.remove_fields(this)")
    end

    def link_to_add_fields(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
        render("#{association}/#{association.to_s.singularize}_fields", f: builder)
      end
      link_to_function(raw("<i class='icon-plus-sign'></i> " + name), "FormHelper.add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: 'btn')
    end

    def link_to_add_slide_fields(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
        render("admin/#{association}/#{association.to_s.singularize}_fields", f: builder)
      end
      link_to_function(raw("<i class='icon-plus-sign'></i> " + name), "FormHelper.add_slide_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: 'btn')
    end

    def link_to_add_fields_row(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render("#{association}/#{association.to_s.singularize}_fields", f: builder)
      end
      link_to_function(raw("<i class='icon-plus-sign'></i> " + name), "FormHelper.add_fields_row(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: 'btn')
    end

  end
end