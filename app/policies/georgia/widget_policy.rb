module Georgia
  class WidgetPolicy < ApplicationPolicy

    def index?
      manage?
    end

    def show?
      manage?
    end

    def new?
      manage?
    end

    def create?
      manage?
    end

    def edit?
      manage?
    end

    def update?
      manage?
    end

    def destroy?
      manage?
    end

    private

    def manage?
      widget_permissions.include?(true)
    end

    def widget_permissions
      Georgia.permissions[:content][:manage_widgets]
    end
  end
end