require 'spec_helper'
include Warden::Test::Helpers

module AuthenticationHelpers
  def create_logged_in_user
    @user ||= create(:admin)
    login(@user)
    @user
  end

  def login(user)
    login_as user, scope: :user
  end
end