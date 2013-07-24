require 'cancan'

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Georgia::User.new

    if user.has_role? 'Admin'
      can :manage, :all
    elsif user.has_role? 'Editor'
      can :manage, :all
      cannot :manage, Georgia::User
    else # or if user is Guest
      can [:read, :edit, :update, :search, :draft, :review], :all
      cannot :manage, Georgia::User
    end
  end
end