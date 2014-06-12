module Georgia
  class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    has_many :role_assignments, dependent: :destroy
    has_many :roles, through: :role_assignments

    def role_names
      @role_names ||= roles.pluck(:name)
    end

    def name
      [first_name, last_name].join(' ')
    end

  end
end