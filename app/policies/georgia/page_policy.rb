module Georgia
  class PagePolicy < ApplicationPolicy

    include Georgia::Concerns::ContentPolicy
    include Georgia::Concerns::PublishingPolicy

    class Scope < Struct.new(:user, :scope)
      def resolve
        Georgia::Page.all
      end
    end

    def index?
      content_user_permissions(:show_pages).include?(true)
    end

    def create?
      content_user_permissions(:create_pages).include?(true)
    end

    def settings?
      content_user_permissions(:edit_page_settings).include?(true)
    end

  end
end