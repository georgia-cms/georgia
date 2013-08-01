require 'active_support/concern'

module Georgia
  module Concerns
    module Publishable
      extend ActiveSupport::Concern
      include Helpers

      included do

        before_filter :prepare_publisher, only: [:publish, :unpublish, :draft, :review, :store, :approve]

        def publish
          @publisher.publish
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
          @draft = @publisher.create_draft
          redirect_to [:edit, @publisher.meta_page, @draft], notice: "You successfully started a new draft of #{@draft.title}. Submit for review when completed."
        end

        def review
          @draft = model.find(params[:id])
          @review = @publisher.review(@draft)
          notify("#{current_user.name} is asking you to review #{@page.title} #{instance_name}.")
          redirect_to [:edit, @publisher.meta_page, @review], notice: "You successfully submited #{@review.title} for review."
        end

        def approve
          @review = model.find(params[:id])
          @page = @publisher.approve(@review)
          message = "#{current_user.name} has successfully published #{@page.title} #{instance_name}."
          notify(message)
          redirect_to [:details, @page], notice: message
        end

        def store
          @publisher.store(@page)
          message = "#{current_user.name} stored #{@page.title} #{instance_name}."
          redirect_to :back, notice: message
        end

        private

        def prepare_publisher
          uuid = inferred_meta_page_id
          @publisher = Georgia::Publisher.new(uuid, user: current_user)
          @page = Georgia::PageDecorator.decorate(@publisher.meta_page)
        end

        def notify(message)
          Notifier.notify_editors(message, url_for(action: :edit, controller: controller_name, id: @page.id)).deliver
        end

        def inferred_meta_page_id
          meta_page_key = params.keys.select{|k| k.match(/.*_id$/)}.first
          params.fetch(meta_page_key, params[:id])
        end

      end

    end
  end
end
