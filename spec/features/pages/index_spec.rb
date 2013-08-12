require 'spec_helper'

describe 'pages#index' do

  it 'lists various pages'
  it 'has hidden drafts rows'
  it 'has hidden reviews rows'

  describe 'create' do

    before :each do
      login_as_admin
    end

    context 'with a valid title' do
      it 'redirects to show page', js: true do
        find('a.js-new-page').click
        fill_in 'Title', with: 'Foo'
        click_button('Create')
        page.should have_content 'Foo'
      end
    end

    context 'with an invalid title' do
      it 'displays an error message', js: true do
        find('a.js-new-page').click
        fill_in 'Title', with: '#@$%^&'
        click_button('Create')
        page.should have_selector('.alert-error', text: "You need a valid and unique page title. Your page title can only consist of letters, numbers, dash (-) and underscore (_)")
      end
    end

  end

end