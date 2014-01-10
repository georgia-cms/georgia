module Georgia
  class DashboardController < Georgia::ApplicationController

    def show
      if can?(:approve, Georgia::Revision)
        @awaiting_revisions = Georgia::Revision.reviews.select{|r| r.revisionable.present?}
      end
    end

  end
end