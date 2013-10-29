module Georgia
  module PresentersHelper

    def page_action_list view, page, options={}
      Georgia::PageActionList.new(self, page, options.reverse_merge(class: 'btn-action'))
    end

    def revision_action_list view, revision, options={}
      Georgia::RevisionActionList.new(self, revision, options.reverse_merge(class: 'btn-action'))
    end

  end
end
