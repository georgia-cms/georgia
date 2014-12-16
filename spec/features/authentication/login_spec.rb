require 'rails_helper'

describe 'User signs in', type: :feature do

  before :all do
    Georgia::User.destroy_all
    PublicActivity::Activity.destroy_all
    create(:georgia_user, email: 'test@me.com', password: '1234-get-the-kittens-out-the-door', password_confirmation: '1234-get-the-kittens-out-the-door')
  end

  before :each do
    @login_page = Login.new
    @login_page.load
  end

  after :all do
    Georgia::User.destroy_all
  end

  context 'with valid email and password' do
    it 'logs in successfully', js: true do
      @login_page.email_field.set 'test@me.com'
      @login_page.password_field.set '1234-get-the-kittens-out-the-door'
      @login_page.submit_button.click
      expect(page).to have_content 'Signed in successfully'
    end
  end

  context 'with invalid email' do
    it 'returns an error message' do
      @login_page.email_field.set 'wrong@wrong.com'
      @login_page.password_field.set '1234-get-the-kittens-out-the-door'
      @login_page.submit_button.click
      expect(@login_page.error_message).to have_text 'Invalid email or password'
    end
  end

  context 'with blank password' do
    it 'returns an error message' do
      @login_page.email_field.set 'test@me.com'
      @login_page.password_field.set ''
      @login_page.submit_button.click
      expect(@login_page.error_message).to have_text 'Invalid email or password'
    end
  end

end
