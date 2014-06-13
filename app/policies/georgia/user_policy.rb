module Georgia
  class UserPolicy < ApplicationPolicy

    def index?
      users_user_permissions(:show_users).include?(true)
    end

    def show?
      edit?
    end

    def new?
      create?
    end

    def create?
      users_user_permissions(:create_users).include?(true)
    end

    def edit?
      update?
    end

    def update?
      users_user_permissions(:update_users).include?(true)
    end

    def destroy?
      users_user_permissions(:delete_users).include?(true)
    end

    def permissions?
      true
    end

    private

    def users_permissions
      Georgia.permissions[:users]
    end

    def users_user_permissions action
      user_permissions(users_permissions, action)
    end
  end
end