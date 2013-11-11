module Georgia
  class ActiveFacetPresenter

    def initialize view_context, text, param, options={}
      @view_context = view_context
      @text = text
      @param = param
      @options = options
    end

    def to_s
      link_to url_for(unmerged_params), class: 'label label-primary' do
        "#{@text} #{icon_tag('times')}".html_safe
      end
    end

    def method_missing(*args, &block)
      @view_context.send(*args, &block)
    end

    private

    def unmerged_params
      params.merge(@param => ((params[@param] || []) - [@text]))
    end
  end
end