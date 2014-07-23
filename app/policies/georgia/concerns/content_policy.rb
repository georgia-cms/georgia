require 'active_support/concern'

module Georgia
  module Concerns
    module ContentPolicy
      extend ActiveSupport::Concern

      included do

        def search?
          index?
        end

        def preview?
          content_user_permissions(:preview_pages).include?(true)
        end

        def copy?
          content_user_permissions(:copy_pages).include?(true)
        end

        def show?
          edit?
        end

        def new?
          create?
        end

        def edit?
          update?
        end

        def update?
          content_user_permissions(:update_pages).include?(true)
        end

        def destroy?
          content_user_permissions(:delete_pages).include?(true)
        end

        private

        def content_permissions
          Georgia.permissions[:content]
        end

        def content_user_permissions action
          user_permissions(content_permissions, action)
        end

      end

    end
  end
end