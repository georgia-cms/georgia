module Georgia
  class DashboardPolicy < ApplicationPolicy

    def show?
      true
    end

    class Scope < Struct.new(:user, :scope)
      def resolve
        revision_policy = Georgia::RevisionPolicy.new(current_user, Georgia::Revision)
        if revision_policy.approve? or revision_policy.review?
          scope.review.select{|r| r.revisionable.present?}
        else
          scope.none
        end
      end
    end
  end
end