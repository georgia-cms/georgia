require 'active_support/concern'

module Georgia
  module Concerns
    module Revisionable
      extend ActiveSupport::Concern

      included do

        belongs_to :published_by, class_name: Georgia::User

        has_one :published_page, foreign_key: :uuid, primary_key: :uuid
        has_many :drafts, foreign_key: :uuid, primary_key: :uuid
        has_many :revisions, foreign_key: :uuid, primary_key: :uuid
        has_many :reviews, foreign_key: :uuid, primary_key: :uuid

        # Look for PublishedStateObserver for callbacks on `publish`, `ask_for_review`, `revision` and `draft`
        state_machine :state, initial: :draft do

          state :published
          state :draft

          event :publish do
            transition all => :published
          end

          event :draft do
            transition all => :draft
          end

          event :ask_for_review

        end

        alias_method :unpublish, :draft
        alias_method :wait_for_review, :ask_for_review

        def status_name
          warn "[DEPRECATION] `status_name` is deprecated.  Please use `human_state_name` instead."
          human_state_name
        end

        def store_as_revision
          Georgia::Revision.store(self)
        end

        def store_as_review
          Georgia::Review.store(self)
        end

        def store_as_draft
          Georgia::Draft.store(self)
        end

      end

      module ClassMethods

        def published
          warn "[DEPRECATION] `published` is deprecated.  Please use `with_states(:published)` instead."
          with_states(:published)
        end

        def draft
          warn "[DEPRECATION] `draft` is deprecated.  Please use `with_states(:draft)` instead."
          with_states(:draft)
        end

        def pending_review
          warn "[DEPRECATION] `pending_review` is deprecated.  Please use `with_states(:pending_review)` instead."
          with_states(:pending_review)
        end

      end

    end
  end
end