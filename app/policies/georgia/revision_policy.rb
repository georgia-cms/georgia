module Georgia
  class RevisionPolicy < ApplicationPolicy

    include Georgia::Concerns::ContentPolicy
    include Georgia::Concerns::PublishingPolicy

    class Scope < Struct.new(:user, :scope)
      def resolve
        Georgia::Revision.all
      end
    end

    def index?
      publishing_user_permissions(:show_revisions).include?(true)
    end

    def create?
      publishing_user_permissions(:create_new_revision).include?(true)
    end

  end
end