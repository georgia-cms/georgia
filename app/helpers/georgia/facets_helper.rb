module Georgia
  module FacetsHelper

    def facet_link_tag text, param
      Georgia::FacetPresenter.new(self, text, param)
    end

    def facet_tag_list taggable_instance
      output = ActiveSupport::SafeBuffer.new
      taggable_instance.tag_list.each{|tag| output << Georgia::FacetPresenter.new(self, tag, :tg) }
      output
    end

    def active_facet_list(*facets)
      return unless facets and !facets.empty?
      output = ActiveSupport::SafeBuffer.new
      facets.each do |param|
        params[param].each{|v| output << Georgia::ActiveFacetPresenter.new(self, v, param) } if params[param] and !params[param].empty?
      end
      content_tag(:div, ("Your selection: " + output).html_safe, class: 'active-facets') if output and !output.blank?
    end
  end
end