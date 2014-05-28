module Georgia
  class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    belongs_to :role

    scope :admins,  -> { includes(:role).where(georgia_roles: {name: 'Admin'}).first }
    scope :editors, -> { includes(:role).where(georgia_roles: {name: 'Editor'}).first }

    delegate :name, to: :role, prefix: true

    def name
      [first_name, last_name].join(' ')
    end

  end
end