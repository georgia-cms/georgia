require 'spec_helper'

describe Georgia::PagesController do
  include Devise::TestHelpers

  before :all do
    @page = FactoryGirl.create :georgia_page
  end

  before :each do
    controller.class.skip_before_filter :authenticate_user!
    controller.stub current_user: FactoryGirl.create(:admin)
  end

  describe "GET search" do
    it "should have a status code of 200" do
      get :search, use_route: :admin
      response.should be_ok
    end
  end

  it "should render the show action" do
    get :show, {use_route: :admin, id: @page.id}
    assigns(:page).should eq @page
  end

  it "should render the edit action" do
    get :edit, {use_route: :admin, id: @page.id}
    assigns(:page).should eq @page
  end
end
