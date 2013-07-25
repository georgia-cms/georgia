require 'active_support/concern'

module Georgia
  module Concerns
    module Revisionable
      extend ActiveSupport::Concern

      included do

        state_machine :state, initial: :draft do

          state :published
          state :draft
          state :review
          state :revision

          event :publish do
            transition all => :published
          end

          event :unpublish do
            transition all => :draft
          end

          event :draft do
            transition all => :draft
          end

          event :review do
            transition all => :review
          end

          event :store do
            transition all => :revision
          end

        end

        alias_method :unpublish, :draft

        def status_name
          warn "[DEPRECATION] `status_name` is deprecated.  Please use `human_state_name` instead."
          human_state_name
        end

        def publisher
          @publisher ||= Georgia::Publisher.new(self.uuid)
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

      end

    end
  end
end