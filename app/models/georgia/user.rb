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

    scope :admins, includes(:roles).where(georgia_roles: {name: 'Admin'})
    scope :editors, includes(:roles).where(georgia_roles: {name: 'Editor'})

    def publish page
      page.update_attribute(:published_by, self)
      page.publish
      page.save!
    end

    def approve review
      page = review.becomes(Georgia::MetaPage)
      page.publish
      page.update_attribute(:published_by, self)
      page.save!
      page
    end

    def name
      [first_name, last_name].join(' ')
    end

    def roles_names
      roles.map(&:name).join(', ')
    end

  end
end