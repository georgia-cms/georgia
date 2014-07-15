module Georgia
  class ApiPolicy < ApplicationPolicy

    def index?
      true
    end

    def search?
      index?
    end

  end
end