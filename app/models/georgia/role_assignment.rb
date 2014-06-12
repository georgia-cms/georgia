module Georgia
  class RoleAssignment < ActiveRecord::Base

    belongs_to :role
    belongs_to :user

  end
end