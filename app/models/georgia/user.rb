module Georgia
  class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    if needs_attr_accessible?
      attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :role_ids, :receives_notifications
    end

    has_and_belongs_to_many :roles, join_table: :roles_users

    def has_role? role
      return false unless role
      @role_names ||= roles.map(&:name)
      @role_names.include? role.to_s.titleize
    end

    scope :admins, includes(:roles).where(georgia_roles: {name: 'Admin'})
    scope :editors, includes(:roles).where(georgia_roles: {name: 'Editor'})

    def name
      [first_name, last_name].join(' ')
    end

    def roles_names
      roles.map(&:name).join(', ')
    end

  end
end