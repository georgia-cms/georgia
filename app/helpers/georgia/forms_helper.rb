module Georgia
  module FormsHelper

    def sortable(column, title = nil)
      title ||= column.titleize
      css_class = (column == sort_column ? "current #{sort_direction}" : nil)
      direction = (column == sort_column && sort_direction == "asc" ? "desc" : "asc")
      link_to title, {sort: column, direction: direction}, {class: css_class}
    end

    def render_template template
      begin
        render "georgia/pages/templates/#{template}", template: template
      rescue
        render "georgia/pages/templates/custom", template: template
      end
    end

    def parent_page_collection
      Georgia::Page.scoped.decorate.sort_by(&:title).map{|p| [p.title, p.id]}
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

  end
end