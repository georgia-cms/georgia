require 'spec_helper'

describe 'pages#index' do

  before :each do
    create_logged_in_user
    visit georgia.pages_path
  end

  it 'has a title' do
    expect(page).to have_selector('h1', text: 'Pages')
  end

  it 'has a table' do
    expect(page).to have_table('table')
  end

  describe 'create' do

    context 'with a valid Title', js: true do
      it 'redirects to edit page' do
        expect(page).to have_link('Add Page', count: 2)
        within 'h1' do
          click_link('Add Page')
        end
        fill_in 'Title', with: 'Foo'
        click_button('Create')
        assert_redirect_to georgia.edit_page_path
      end
    end

  end

  describe 'search' do
    it 'has a search form' do
      visit georgia.pages_path
      expect(page).to have_field(:query)
    end
  end

  describe 'facets' do

  end
end