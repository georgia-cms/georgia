require 'active_support/concern'

module Georgia
  module Concerns
    module Statusable
      extend ActiveSupport::Concern

      included do

        belongs_to :status, class_name: Georgia::Status
        belongs_to :published_by, class_name: Georgia::User

        attr_accessible :published_by_id, :published_at

        delegate :published?, :draft?, :pending_review?, to: :status, allow_nil: true

        before_save :ensure_status, on: :create

        scope :published, joins(:status).where('georgia_statuses' => {name: Georgia::Status::PUBLISHED})
        scope :draft, joins(:status).where('georgia_statuses' => {name: Georgia::Status::DRAFT})
        scope :pending_review, joins(:status).where('georgia_statuses' => {name: Georgia::Status::PENDING_REVIEW})

        def publish(user)
          self.published_by = user
          self.published_at = Time.zone.now
          self.status = Georgia::Status.published.first
          self
        end

        def unpublish
          self.status = Georgia::Status.draft.first
          self
        end

        def wait_for_review
          self.status = Georgia::Status.pending_review.first
          self
        end

        protected

        def ensure_status
          self.status ||= Georgia::Status.draft.first
        end

      end

      module ClassMethods
      end
    end
  end
end