module Georgia
  class ApplicationPolicy
    attr_reader :user,  :record

    def initialize(user, record)
      raise Pundit::NotAuthorizedError, "Must be signed in." unless user
      @user   = user
      @record = record
    end

    def scope
      Pundit.policy_scope!(user, record.class)
    end

    def search?
      index?
    end

    private

    def user_roles
      @user_roles ||= @user.role_names
    end

    def user_permissions permissions, action
      user_roles.map{|r| permissions[action].fetch(r, false)}
    end

  end
end