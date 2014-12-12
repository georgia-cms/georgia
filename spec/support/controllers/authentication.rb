include Warden::Test::Helpers

module AuthenticationHelpers
  def create_logged_in_user
    @user = create(:georgia_user)
    @user.stub(:has_role?).with('Admin') { true }
    login_as @user, scope: :georgia_user, run_callbacks: false
    @user
  end

  def login_as_admin
    visit '/admin/login'
    admin = create(:georgia_user, :admin)
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Log in'
  end

end