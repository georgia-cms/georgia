require 'spec_helper'

describe 'pages#show' do

  before :each do
    login_as_admin
  end

  describe 'publishing' do

    before :each do
      georgia_page = create(:georgia_page, public: published)
      visit georgia.page_path(georgia_page)
    end

    context 'when private' do
      let(:published) {false}
      it 'marks the page as public' do
        page.should have_content('private')
        click_link('Publish')
        page.should have_content('public')
      end
    end

    context 'when published' do
      let(:published) {true}
      it 'marks the page as private' do
        page.should have_content('public')
        click_link('Unpublish')
        page.should have_content('private')
      end
    end

  end

end