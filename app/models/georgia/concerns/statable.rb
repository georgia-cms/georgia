require 'active_support/concern'

module Georgia
  module Concerns
    module Statable
      extend ActiveSupport::Concern

      included do

        attr_accessible :state
        state_machine :state, initial: :draft do

          state :published
          state :draft
          state :review
          state :revision

          # Drafts
          event :review do
            transition :draft => :review
          end

          # Reviews
          event :approve do
            transition :review => :published
          end
          event :decline do
            transition :review => :draft
          end

          # Published
          event :store do
            transition :published => :revision
          end
          event :unpublish do
            transition :published => :draft
          end

          # Revisions
          event :revert do
            transition :revision => :published
          end

          after_transition any => :published do |revision, transition|
            revision.revisionable.publish(revision)
          end

        end

        scope :published, with_states(:published)
        scope :drafts, with_states(:draft)
        scope :reviews, with_states(:review)
        scope :stored, with_states(:revision)

        def status_name
          warn "[DEPRECATION] `status_name` is deprecated.  Please use `human_state_name` instead."
          human_state_name
        end

      end

    end
  end
end