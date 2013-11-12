require 'spec_helper'
include Warden::Test::Helpers

module AuthenticationHelpers
  def create_logged_in_user
    @user ||= create(:admin)
    login(@user)
    @user
  end

  def login(user)
    login_as user, scope: :georgia_user, run_callbacks: false
  end

  def login_as_admin
    visit '/admin/login'
    admin = create(:admin)
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log In'
  end

end