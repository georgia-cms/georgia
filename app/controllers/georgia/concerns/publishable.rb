require 'active_support/concern'

module Georgia
  module Concerns
    module Publishable
      extend ActiveSupport::Concern
      include Helpers

      included do

        before_filter :prepare_publisher, only: [:publish, :unpublish, :draft, :review, :store]

        def publish
          @publisher.publish(@page)
          message = "#{current_user.name} has successfully published #{@page.title} #{instance_name}."
          notify(message)
          redirect_to :back, notice: message
        end

        def unpublish
          @publisher.unpublish
          message = "#{current_user.name} has successfully unpublished #{@page.title} #{instance_name}."
          notify(message)
          redirect_to :back, notice: message
        end

        def draft
          @publisher.draft(@page)
          redirect_to :back, notice: "You successfully started a new draft of #{@draft.title}. Ask for review when completed."
        end

        def review
          @publisher.unpublish(@page)
          notify("#{current_user.name} is asking you to review #{@page.title} #{instance_name}.")
          redirect_to :back, notice: message
        end

        def store
          @publisher.store(@page)
          message = "#{current_user.name} stored #{@page.title} #{instance_name}."
          redirect_to :back, notice: message
        end

        private

        def prepare_publisher
          @page = Georgia::PageDecorator.decorate(model.find(params[:id]))
          @publisher = Georgia::Publisher.new(@page.uuid, user: current_user)
        end

        def notify(message)
          Notifier.notify_editors(message, url_for(action: :edit, controller: controller_name, id: @page.id)).deliver
        end

      end

    end
  end
end
