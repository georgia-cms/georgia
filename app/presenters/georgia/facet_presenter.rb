module Georgia
  class FacetPresenter

    attr_reader :active
    alias :active? :active

    def initialize view_context, text, param, options={}
      @view_context = view_context
      @text = text
      @param = param
      @active = options.fetch(:active, get_active_state_from_params)
      @options = options
    end

    def to_s
      return '' if active?
      link_to(@text, url_for(merged_params), class: 'label label-default')
    end

    def method_missing(*args, &block)
      @view_context.send(*args, &block)
    end

    private

    def get_active_state_from_params
      params[@param] and params[@param].include?(@text)
    end

    def merged_params
      params.merge(@param => ((params[@param] || []) + [@text]))
    end

  end
end