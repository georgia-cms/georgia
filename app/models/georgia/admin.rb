module Georgia
  class Admin < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :role_ids
    # attr_accessible :title, :body

    has_and_belongs_to_many :roles

    def has_role? role
      return false unless role
      @role_names ||= roles.map(&:name)
      @role_names.include? role.to_s.titleize
    end
  end
end