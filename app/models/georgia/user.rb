module Georgia
  class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :role_ids

    has_and_belongs_to_many :roles, class_name: Georgia::Role

    def has_role? role
      return false unless role
      @role_names ||= roles.map(&:name)
      @role_names.include? role.to_s.titleize
    end

    scope :admins, joins(:roles).where(georgia_roles: {name: 'Admin'})
    scope :editors, joins(:roles).where(georgia_roles: {name: 'Editor'})

  end
end