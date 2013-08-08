require 'active_support/concern'

module Georgia
  module Concerns
    module Publishing
      extend ActiveSupport::Concern
      include Helpers

      def draft
        @page = model.find(params[:id])
        @draft = @page.draft
        redirect_to [:edit, @page, @draft], notice: "You successfully started a new draft of #{@draft.title}. Submit for review when completed."
      end

      def publish
        @page = model.find(params[:id])
        @page.publish
        message = "#{current_user.name} has successfully published #{@page.title} #{instance_name}."
        notify(message)
        redirect_to :back, notice: message
      end

      def unpublish
        @page = model.find(params[:id])
        @page.unpublish
        message = "#{current_user.name} has successfully unpublished #{@page.title} #{instance_name}."
        notify(message)
        redirect_to :back, notice: message
      end

    end
  end
end