module Georgia
  class ActiveFacetTagPresenter

    def initialize view_context, tag, options={}
      @view_context = view_context
      @tag = tag
      @options = options
    end

    def to_s
      link_to url_for(unmerged_params), class: 'label label-primary' do
        "#{@tag} #{icon_tag('times')}".html_safe
      end
    end

    def method_missing(*args, &block)
      @view_context.send(*args, &block)
    end

    private

    def unmerged_params
      params.merge(tg: ((params[:tg] || []) - [@tag]))
    end
  end
end