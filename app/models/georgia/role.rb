module Georgia
  class Role < ActiveRecord::Base

    has_many :role_assignments, dependent: :destroy
    has_many :users, through: :role_assignments

    validates :name, presence: true, uniqueness: { case_sensitive: false }

  end
end