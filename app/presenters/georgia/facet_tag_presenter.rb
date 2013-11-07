module Georgia
  class FacetTagPresenter

    attr_reader :active
    alias :active? :active

    def initialize view_context, tag, options={}
      @view_context = view_context
      @tag = tag
      @active = options.fetch(:active, get_active_state_from_params)
      @options = options
    end

    def to_s
      return '' if active?
      link_to(@tag, url_for(merged_params), class: 'label label-default')
    end

    def method_missing(*args, &block)
      @view_context.send(*args, &block)
    end

    private

    def get_active_state_from_params
      params[:tg] and params[:tg].include?(@tag)
    end

    def merged_params
      params.merge(tg: ((params[:tg] || []) + [@tag]))
    end

  end
end