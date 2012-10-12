module Georgia
  module FormsHelper

    def sortable(column, title = nil)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
      link_to title, {sort: column, direction: direction}, {class: css_class}
    end

    def render_template template
      begin
        render "georgia/pages/templates/#{template}", template: template
      rescue
        render "georgia/pages/templates/custom", template: template
      end
    end
  end
end