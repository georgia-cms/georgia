module Georgia
  module PagesHelper

    def page_actions_tag page, revision=nil, options={}
      revision ||= page.current_revision
      Georgia::PageActionsPresenter.new(self, page, revision, options)
    end

    def page_tag_list page
      output = ActiveSupport::SafeBuffer.new
      page.tag_list.each{|tag| output << Georgia::FacetTagPresenter.new(self, tag) }
      output
    end

    def page_active_tag_list
      return unless params[:tg] and !params[:tg].empty?
      output = ActiveSupport::SafeBuffer.new
      params[:tg].each{|tag| output << Georgia::ActiveFacetTagPresenter.new(self, tag) }
      content_tag(:div, ("Your selection: " + output).html_safe, class: 'active-facets')
    end

  end
end
