require 'spec_helper'

describe 'pages#edit' do

  before :each do
    create_logged_in_user
    @page = FactoryGirl.create(:georgia_page)
    visit georgia.edit_pages_path(@page)
  end
end