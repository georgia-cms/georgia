require 'active_support/concern'

module Georgia
  module Concerns
    module Revisionable
      extend ActiveSupport::Concern

      included do

        # Defines helper methods for available actions on classes extending concerns. Default value is false until the concern itself redefines the method and set to true
        [:publishable?, :unpublishable?, :approvable?, :previewable?, :reviewable?, :draftable?, :approvable?, :copyable?, :draftable?].each do |action|
          define_method(action){false}
        end

        state_machine :state, initial: :draft do

          state :published do
            def draftable?
              true
            end

            def publishable?
              true
            end
          end

          state :draft do
            include Georgia::Concerns::Clonable

            def reviewable?
              true
            end
          end
          state :review do
            def approvable?
              true
            end
          end
          state :revision do
          end

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

        delegate :drafts, :reviews, :revisions, to: :publisher

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