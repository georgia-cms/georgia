require 'spec_helper'

describe 'pages#index' do

  before :each do
    create_logged_in_user
    visit georgia.search_pages_url
  end

  describe 'create' do

    context 'with a valid title' do
      it 'redirects to edit page', js: true do
        click_link('Add Page')
        fill_in 'Title', with: 'Foo'
        click_button('Create')
        page.should have_selector('h1', text: "Editing 'Foo'")
      end
    end

    context 'with an invalid title' do
      it 'displays an error message', js: true do
        click_link('Add Page')
        fill_in 'Title', with: '#@$%^&'
        click_button('Create')
        expect(page).to have_selector('.alert-error', text: "You need a valid and unique page title. Your page title can only consist of letters, numbers, dash (-) and underscore (_)")
      end
    end

  end

end