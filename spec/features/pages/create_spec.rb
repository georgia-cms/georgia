require 'rails_helper'

describe 'pages#search', type: :feature do

  def create_page
    within('div.header-actions') do
      find('a').click
    end
    within('#page_form') do
      fill_in 'page_title', with: title
      click_button('Create')
    end
  end

  before :each do
    login_as_admin
    visit georgia.search_pages_path
    create_page
  end

  describe 'creating a page' do

    context 'with a valid title' do

      let(:title) { 'Foo' }
      it 'redirects to revisions#edit', js: true do
        expect(page).to have_css('.header-title > h1 > a', text: title)
      end

    end

    context 'with an invalid title' do

      let(:title) { '#@$%^&' }
      it 'displays an error message', js: true do
        expect(page).to have_css('.alert-error', text: "You need a valid and unique page title. Your page title can only consist of letters, numbers, dash (-) and underscore (_)")
      end

    end

  end

end
