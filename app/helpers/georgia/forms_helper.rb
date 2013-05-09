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

    def parent_page_collection
      Georgia::PageDecorator.decorate(Georgia::Page.scoped).sort_by(&:title).map{|p| [p.title, p.id]}
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
