module Georgia
  module FormsHelper

    def sortable(column, title=nil)
      title ||= column.humanize
      direction = (column.to_s == params[:o] && params[:dir] == "asc" ? "desc" : "asc")
      icon = direction == "asc" ? icon_tag('icon-chevron-up') : icon_tag('icon-chevron-down')
      "#{title} #{link_to(icon, params.merge({o: column, dir: direction}))}".html_safe
    end

    def render_template template
      begin
        render "georgia/pages/templates/#{template}", template: template
      rescue
        render "georgia/pages/templates/custom", template: template
      end
    end

    def widget_portlet view, ui_association, args={}
      Georgia::WidgetPortlet.new(view, ui_association, args)
    end

    def portlet_tag portlet, options={}, &block
      content_tag :li, class: 'portlet', id: dom_id(portlet), data: {portlet: portlet.id} do
        content_tag(:span, icon_tag('resize-vertical'), class: 'handle') + capture(&block)
      end
    end

    def parent_page_collection
      @parent_page_collection ||= Georgia::Page.not_self(@page).joins(current_revision: :contents).uniq.sort_by(&:title).map{|p| [p.title, p.id]}
    end

    def widgets_collection
      @widgets_collection ||= options_from_collection_for_select(Georgia::Widget.all, :id, :title)
    end

    def facets_inputs facets=[]
      facets.map do |f|
        if params[f] and !params[f].empty?
          params[f].map do |v|
            hidden_field_tag(f, v, name: "#{f}[]")
          end
        end
      end.flatten.join().html_safe
    end

    def extra_fields?
      lookup_context.exists?('extra-fields', ["#{klass_folder}/fields"], true)
    end

    def extra_fields_path
      "#{klass_folder}/fields/extra-fields"
    end

    private

    def klass_folder
      klass = @page.try(:decorated?) ? @page.model.class : @page.class
      @klass_folder ||= klass.to_s.underscore.pluralize
    end

  end
end
