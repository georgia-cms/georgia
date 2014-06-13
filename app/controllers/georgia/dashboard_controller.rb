module Georgia
  class DashboardController < Georgia::ApplicationController

    def show
      authorize Georgia::Dashboard
      @awaiting_revisions = policy_scope(Georgia::Revision)
      if defined? GeorgiaMailer::Message
        # if can?(:index, GeorgiaMailer::Message)
          @messages = GeorgiaMailer::Message.ham.latest.limit(5).decorate
        # end
      end
    end

  end
end