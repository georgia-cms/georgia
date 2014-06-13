require 'active_support/concern'

module Georgia
  module Concerns
    module PublishingPolicy
      extend ActiveSupport::Concern

      included do

        def review?
          publishing_user_permissions(:review_changes).include?(true)
        end

        def approve?
          publishing_user_permissions(:approve_changes).include?(true)
        end

        def decline?
          publishing_user_permissions(:decline_changes).include?(true)
        end

        def restore?
          publishing_user_permissions(:restore_changes).include?(true)
        end

        def publish?
          publishing_user_permissions(:publish_pages).include?(true)
        end

        def unpublish?
          publishing_user_permissions(:unpublish_pages).include?(true)
        end

        private

        def publishing_permissions
          Georgia.permissions[:publishing]
        end

        def publishing_user_permissions action
          user_permissions(publishing_permissions, action)
        end

      end

    end
  end
end