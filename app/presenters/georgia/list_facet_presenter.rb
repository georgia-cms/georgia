module Georgia
  class ListFacetPresenter < Presenter

    attr_reader :list, :param, :options

    def initialize view_context, list, param, options={}
      super
      @list = list
      @param = param
      @options = options
    end

    def to_s
      output = ActiveSupport::SafeBuffer.new
      list.each do |text|
        output << link_to(text, url_for(merged_params(text)), class: 'label label-default') unless active?(text)
      end
      output
    end

    private

    def active?(text)
      params[param] and params[param].include?(text)
    end

    def merged_params(text)
      params.reject{|k,v| k == 'page'}.merge(param => ((params[param] || []) + [text]))
    end

  end
end