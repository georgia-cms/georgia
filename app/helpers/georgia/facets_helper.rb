module Georgia
  module FacetsHelper

    def facets_inputs facets=[]
      facets.map do |f|
        if params[f] and !params[f].empty?
          params[f].map do |v|
            hidden_field_tag(f, v, name: "#{f}[]")
          end
        end
      end.flatten.join().html_safe
    end

    def facet_tag text, param, options={}
      Georgia::FacetPresenter.new(self, text, param, options)
    end

    def facet_list_tag list, param, options={}
      Georgia::ListFacetPresenter.new(self, list, :tg, options)
    end

    def active_facet_list(*facets)
      return unless facets and !facets.empty?
      output = ActiveSupport::SafeBuffer.new
      facets.each do |param|
        if params[param] and params[param].is_a?(Array)
          params[param].each{|v| output << Georgia::ActiveFacetPresenter.new(self, v, param) } if params[param] and !params[param].empty?
        else
          output << Georgia::SingleActiveFacetPresenter.new(self, params[param], param) if params[param].present?
        end
      end
      content_tag(:div, ("Your selection: " + output).html_safe, class: 'active-facets') if output and !output.blank?
    end
  end
end