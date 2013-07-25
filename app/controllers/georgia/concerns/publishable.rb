require 'active_support/concern'

module Georgia
  module Concerns
    module Publishable
      extend ActiveSupport::Concern
      include Helpers

      def publish
        @page = Georgia::PageDecorator.decorate(model.find(params[:id]))
        current_user.publish @page
        message = "#{current_user.name} has successfully published #{@page.title} #{instance_name}."
        notify(message)
        redirect_to :back, notice: message
      end

      def unpublish
        @page = Georgia::PageDecorator.decorate(model.find(params[:id]))
        @page.draft
        if @page.save
          message = "#{current_user.name} has successfully unpublished #{@page.title} #{instance_name}."
          notify(message)
          redirect_to :back, notice: message
        else
          render :edit
        end
      end

      def draft
        @page = Georgia::PageDecorator.decorate(model.find(params[:id]))
        @draft = @page.store_as_draft
        @draft.update_attribute(:created_by, current_user)
        @draft.update_attribute(:updated_by, current_user)
        redirect_to georgia.edit_draft_path(@draft), notice: "You successfully started a new draft of #{@draft.title}. Ask for review when completed."
      end

      def review
        @page = model.find(params[:id])
        @review = @page.wait_for_review
        @review.update_attribute(:updated_by, current_user)
        message = "#{current_user.name} is asking you to review #{@page.title} #{instance_name}."
        notify(message)
        redirect_to [:search, model], notice: message
      end

      def store
        @page = model.find(params[:id])
        @page.store_as_revision
        redirect_to [:edit, @page], notice: "Successfully stored a new revision"
      end

      private

      def notify(message)
        Notifier.notify_editors(message, url_for(action: :edit, controller: controller_name, id: @page.id)).deliver
      end

    end
  end
end
