require 'spec_helper'

feature 'User signs in' do

  before :all do
    FactoryGirl.create(:admin, email: 'test@me.com', password: '1234-get-the-kittens-out-the-door', password_confirmation: '1234-get-the-kittens-out-the-door')
  end

  scenario 'with valid email and password' do
    log_in_with 'test@me.com', '1234-get-the-kittens-out-the-door'

    expect(page).to have_content('Signed in successfully')
  end

  scenario 'with invalid email' do
    log_in_with 'wrong@email.com', '1234-get-the-kittens-out-the-door'

    expect(page).to have_content('Invalid email or password')
  end

  scenario 'with blank password' do
    log_in_with 'test@me.com', ''

    expect(page).to have_content('Invalid email or password')
  end

  def log_in_with(email, password)
    visit '/admin/login'
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log In'
  end

end