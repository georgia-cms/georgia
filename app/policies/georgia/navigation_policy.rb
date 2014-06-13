module Georgia
  class NavigationPolicy < ApplicationPolicy

    def index?
      navigation_user_permissions(:show_menus).include?(true)
    end

    def show?
      edit?
    end

    def new?
      create?
    end

    def create?
      navigation_user_permissions(:create_menus).include?(true)
    end

    def edit?
      update?
    end

    def update?
      navigation_user_permissions(:update_menus).include?(true)
    end

    def destroy?
      navigation_user_permissions(:delete_menus).include?(true)
    end

    private

    def navigation_permissions
      Georgia.permissions[:navigation]
    end

    def navigation_user_permissions action
      user_permissions(navigation_permissions, action)
    end
  end
end