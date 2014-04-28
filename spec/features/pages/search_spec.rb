require 'spec_helper'

describe 'pages#search' do

  before :each do
    Georgia::Page.tire.index.delete
    Georgia::Page.tire.create_elasticsearch_index
    login_as_admin
    visit georgia.search_pages_path
  end

  describe 'creating a page' do

    before :each do
      within('div.header-actions') do
        find('a').click
      end
      within('#page_form') do
        fill_in 'page_title', with: title
        click_button('Create')
      end
    end

    context 'with a valid title' do
      let(:title) { 'Foo' }
      it 'redirects to revisions#edit', js: true do
        expect(page).to have_content title
      end
    end

    context 'with an invalid title' do
      let(:title) { '#@$%^&' }
      it 'displays an error message', js: true do
        expect(page).to have_selector('.alert-error', text: "You need a valid and unique page title. Your page title can only consist of letters, numbers, dash (-) and underscore (_)")
      end
    end

  end

end
