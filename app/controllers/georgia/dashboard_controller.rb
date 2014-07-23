module Georgia
  class DashboardController < Georgia::ApplicationController

    def show
      authorize Georgia::Dashboard
      @activities = PublicActivity::Activity.order(created_at: :desc).page(params[:page]).per(20)
      @awaiting_revisions = Georgia::Revision.where("status = ?", Georgia::Revision.statuses[:review])
      if defined? Georgia::Mailer::Message and policy(Georgia::Mailer::Message).index?
        @messages = Georgia::Mailer::Message.ham.latest.limit(5).decorate
      end
    end

  end
end