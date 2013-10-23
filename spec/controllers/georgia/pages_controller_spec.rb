require 'spec_helper'

describe Georgia::PagesController do
  include Devise::TestHelpers

  before :all do
    @page = create :georgia_page
  end

  before :each do
    controller.class.skip_before_filter :authenticate_user!
    controller.stub current_user: create(:admin)
  end

  it "should retrieve the model name of the controller" do
    controller.model.name.should eq("Georgia::Page")
  end

  describe "GET search" do

    it "should have a status code of 200" do
      get :search, use_route: :admin
      response.should be_ok
    end

  end

  describe "GET show" do

    it "should have a status code of 200" do
      get :show, use_route: :admin, id: @page.id
      response.should be_ok
    end

    it "should render the page" do
      get :show, use_route: :admin, id: @page.id
      assigns(:page).should eq @page
    end

  end

end
