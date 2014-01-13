module Georgia
  class FacetPresenter < Presenter

    attr_reader :active, :text, :param, :options
    alias :active? :active

    def initialize view_context, text, param, options={}
      super
      @text = text
      @param = param
      @active = options.fetch(:active, get_active_state_from_params)
      @options = options
    end

    def to_s
      active? ? content_tag(:em, text) : link_to(text, url_for(params.merge(param => text)), class: 'label label-default')
    end

    private

    def get_active_state_from_params
      params[param] and params[param] == text
    end

  end
end