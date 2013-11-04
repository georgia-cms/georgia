module Georgia
  module PagesHelper

    def page_actions_tag page, revision=nil, options={}
      revision ||= page.current_revision
      options[:class] ||= 'btn-action'
      Georgia::PageActionsPresenter.new(self, page, revision, options)
    end

  end
end
