require 'active_support/concern'

module Georgia
  module Concerns
    module Revisioning
      extend ActiveSupport::Concern
      include Helpers

      included do

        before_filter :prepare_revision, only: [:review, :approve, :decline, :revert]

        def review
          @revision.review
          notify("#{current_user.name} is asking you to review #{@revision.title}.")
          redirect_to [:edit, @page, @revision], notice: "You successfully submited #{@revision.title} for review."
        end

        def approve
          @revision.approve
          message = "#{current_user.name} has successfully approved and published #{@revision.title} #{instance_name}."
          notify(message)
          redirect_to [:show, @page], notice: message
        end

        def decline
          @revision.decline
          message = "#{current_user.name} has successfully published #{@revision.title} #{instance_name}."
          notify(message)
          redirect_to [:edit, @page, @revision], notice: message
        end

        def revert
          @revision.revert
          message = "#{current_user.name} has successfully published #{@revision.title} #{instance_name}."
          notify(message)
          redirect_to [:show, @page], notice: message
        end

        private

        def prepare_revision
          @page = Georgia::Page.find(params[:page_id])
          @revision = Georgia::Revision.find(params[:id])
        end

        def notify(message)
          Notifier.notify_editors(message, url_for(action: :edit, controller: controller_name, id: @page.id)).deliver
        end

      end

    end
  end
end
