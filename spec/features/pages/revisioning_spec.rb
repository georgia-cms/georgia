require 'spec_helper'

describe 'pages revisioning' do

  before :each do
    login_as_admin
    georgia_page = create(:georgia_page)
    visit georgia.page_path(georgia_page)
  end

  it 'starts a new draft' do
    click_link 'Start a new draft'
    page.should have_content('draft')
  end

  it 'asks for a review' do
    click_link 'Start a new draft'
    click_link 'Ask for Review'
  end

  it 'approves a review' do
    click_link 'Start a new draft'
    click_link 'Ask for Review'
    click_link 'Approve'
  end

end