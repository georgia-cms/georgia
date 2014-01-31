module Georgia
  class DashboardController < Georgia::ApplicationController

    def show
      if can?(:approve, Georgia::Revision) or can?(:review, Georgia::Revision)
        @awaiting_revisions = Georgia::Revision.reviews.select{|r| r.revisionable.present?}
      end
      if defined? GeorgiaMailer::Message
        if can?(:index, Georgia::Message)
          @messages = Georgia::Message.ham.latest.limit(5).decorate
        end
      end
    end

  end
end