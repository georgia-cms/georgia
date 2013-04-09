require 'active_support/concern'

module Georgia
  module Concerns
    module Publishable
      extend ActiveSupport::Concern

      def publish
        @publishable_resource = associated_model.find(params[:id]).decorate
        @publishable_resource.store_revision do
          @publishable_resource.publish current_user
          @publishable_resource.save!
        end
        message = "#{current_user.decorate.name} has successfully published #{@publishable_resource.title} #{instance_name}."
        notify(message)
        redirect_to :back, notice: message
      end

      def unpublish
        @publishable_resource = associated_model.find(params[:id]).decorate
        @publishable_resource.unpublish
        if @publishable_resource.save
          message = "#{current_user.decorate.name} has successfully unpublished #{@publishable_resource.title} #{instance_name}."
          notify(message)
          redirect_to :back, notice: message
        else
          render :edit
        end
      end

      def ask_for_review
        @publishable_resource = associated_model.find(params[:id]).decorate
        @publishable_resource.wait_for_review
        if @publishable_resource.save
          message = "#{current_user.decorate.name} is asking you to review #{@publishable_resource.title} #{instance_name}."
          notify(message)
          redirect_to :back, notice: message
        else
          render :edit
        end
      end

      private
      def associated_model
        begin
          self.class.name.sub('Controller', '').singularize.constantize
        rescue NameError
          controller_name.singularize.camelize.safe_constantize
        end
      end

      def instance_name
        controller_name.singularize.titleize
      end

      def notify(message)
        Notifier.notify_editors(message, namespaced_url_for(@publishable_resource, {action: :edit, controller: self.class.name})).deliver if Rails.env.production?
      end

    end
  end
end
