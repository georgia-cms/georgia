require 'active_support/concern'

module Georgia
  module Concerns
    module Publishable
      extend ActiveSupport::Concern
      include Helpers

      def publish
        @page = Georgia::PageDecorator.decorate(model.find(params[:id]))
        current_user.publish @page
        message = "#{current_user.decorate.name} has successfully published #{@page.title} #{instance_name}."
        notify(message)
        redirect_to :back, notice: message
      end

      def unpublish
        @page = Georgia::PageDecorator.decorate(model.find(params[:id]))
        @page.draft
        if @page.save
          message = "#{current_user.decorate.name} has successfully unpublished #{@page.title} #{instance_name}."
          notify(message)
          redirect_to :back, notice: message
        else
          render :edit
        end
      end

      def ask_for_review
        @page = Georgia::PageDecorator.decorate(model.find(params[:id]))
        @page.wait_for_review
        if @page.save
          message = "#{current_user.decorate.name} is asking you to review #{@page.title} #{instance_name}."
          notify(message)
          redirect_to :back, notice: message
        else
          render :edit
        end
      end

      private

      def notify(message)
        Notifier.notify_editors(message, url_for(action: :edit, controller: controller_name, id: @page.id)).deliver
      end

    end
  end
end
