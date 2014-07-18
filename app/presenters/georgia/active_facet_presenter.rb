module Georgia
  class ActiveFacetPresenter < Presenter

    attr_reader :text, :param

    def initialize view_context, text, param, options={}
      super
      @text = text
      @param = param
      @options = options
    end

    def to_s
      link_to url_for(unmerged_params), class: 'label label-primary' do
        "#{text} #{icon_tag('times')}".html_safe
      end
    end

    private

    def unmerged_params
      facets = (params[param] || []) - [text]
      facets.any? ? params.merge(param => facets) : params.except(param)
    end
  end
end