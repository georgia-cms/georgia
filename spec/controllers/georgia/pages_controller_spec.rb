require 'rails_helper'

describe Georgia::PagesController, type: :controller do
  render_views

  before :all do
    @page = create(:georgia_page)
  end

  before :each do
    @current_user = create(:georgia_user, :admin)
    controller.class.skip_before_filter :authenticate_user!
    allow(controller).to receive(:current_user).and_return(@current_user)
    allow(controller).to receive(:controller_name).and_return('georgia/pages')
  end

  it "retrieves the model name of the controller" do
    expect(controller.model.name).to eq("Georgia::Page")
  end

  describe "GET search" do

    it "has a status code of 200" do
      get :search, use_route: :admin
      expect(response).to be_success
    end

    it 'assigns @pages' do
      Georgia::Page.import(force: true, refresh: true)
      get :search, use_route: :admin, query: 'Lorem'
      expect(assigns(:pages)).to be_decorated
      expect(assigns(:pages)).to include @page
    end

  end

  describe "GET index" do

    it "redirects to search" do
      get :index, use_route: :admin, id: @page.id
      expect(response).to be_redirect
    end

  end

  describe "GET show" do

    it "redirects to edit" do
      get :show, use_route: :admin, id: @page.id
      expect(response).to be_redirect
    end

  end

  describe "GET edit" do

    it "redirects to revisions#edit" do
      get :edit, use_route: :admin, id: @page.id
      expect(response).to be_redirect
    end

  end

  describe "GET settings" do

    it "has a status code of 200" do
      get :settings, use_route: :admin, id: @page.id
      expect(response).to be_success
    end

    it "renders the page" do
      get :settings, use_route: :admin, id: @page.id
      expect(assigns(:page)).to eq @page
    end

  end

  describe "GET copy" do

    it "redirects to revisions#edit" do
      get :copy, use_route: :admin, id: @page.id
      expect(response).to be_redirect
    end

  end

  describe "POST create" do

    it "redirects to revisions#edit" do
      post :create, use_route: :admin, title: "New page"
      expect(response).to be_redirect
    end

    it "assigns a current_revision with contents" do
      post :create, use_route: :admin, title: "New page"
      expect(assigns(:page).current_revision).to be_a_kind_of Georgia::Revision
      expect(assigns(:page).current_revision.contents).not_to be_empty
    end

    it "assigns a revision with title" do
      post :create, use_route: :admin, title: "New page"
      expect(assigns(:page).current_revision.contents.first.title).to match "New page"
    end

    it "assigns a revision with a locale" do
      post :create, use_route: :admin, title: "New page"
      expect(assigns(:page).current_revision.contents.first.locale).to_not be_nil
    end

    it "assigns a revision with default template" do
      post :create, use_route: :admin, title: "New page"
      expect(assigns(:page).current_revision.template).to match 'default'
    end

  end

  describe "PUT update" do

    it "has a status code of 200" do
      put :update, use_route: :admin, id: @page.id, page: {slug: 'foobar'}
      expect(response).to be_redirect
    end

  end

end