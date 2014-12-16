require 'rails_helper'

describe Georgia::RevisionsController, type: :controller do
  render_views

  before :all do
    @page = create(:georgia_page)
    @revision = @page.current_revision
  end

  before :each do
    @current_user = create(:georgia_user, :admin)
    controller.class.skip_before_filter :authenticate_user!
    allow(controller).to receive(:current_user).and_return(@current_user)
    allow(controller).to receive(:controller_name).and_return('georgia/revisions')
  end

  describe "GET index" do

    it "has a status code of 200" do
      get :index, use_route: :admin, page_id: @page.id
      expect(response).to be_ok
    end

    it "assigns a page" do
      get :index, use_route: :admin, page_id: @page.id
      expect(assigns(:page)).to eq @page
    end

    it "assigns revisions" do
      get :index, use_route: :admin, page_id: @page.id
      expect(assigns(:revisions).length).to eq 1
    end

  end

  describe "GET show" do

    it "redirects to edit" do
      get :show, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(response).to be_redirect
    end

    it "assigns a page" do
      get :show, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(assigns(:page)).to eq @page
    end

    it "assigns a revision" do
      get :show, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(assigns(:revision)).to eq @revision
    end

  end

  describe "GET edit" do

    it "has a status code of 200" do
      get :edit, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(response).to be_ok
    end

    it "assigns a page" do
      get :edit, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(assigns(:page)).to eq @page
    end

    it "assigns a revision" do
      get :edit, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(assigns(:revision)).to eq @revision
    end

    it "assigns ui_sections" do
      create :georgia_ui_section
      get :edit, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(assigns(:ui_sections).length).to be 1
    end

  end

  describe "PUT update" do

    let(:revision_attributes) { { contents_attributes: { @revision.content.id.to_s => { title: "You used to be much more...muchier. You've lost your muchness.", id: @revision.content.id } } } }
    let(:update_revision) { put :update, use_route: :admin, page_id: @page.id, id: @revision.id, revision: revision_attributes }

    it "redirects to edit" do
      update_revision
      expect(response).to be_redirect
      expect(assigns(:revision).title).to eq "You used to be much more...muchier. You've lost your muchness."
    end

    context 'as an admin' do

      it "overwrites the current revision" do
        @page.current_revision = @revision
        @page.save
        expect{update_revision}.not_to change(Georgia::Revision, :count)
      end

    end

  end

  describe "GET request_review" do

    it "redirects to edit" do
      get :request_review, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(response).to be_redirect
    end

  end

  describe "GET approve" do

    it "redirects to @page" do
      get :approve, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(response).to be_redirect
    end

  end

  describe "GET decline" do

    it "redirects to edit" do
      get :decline, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(response).to be_redirect
    end

  end

  describe "GET restore" do

    it "redirects to @page" do
      get :restore, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(response).to be_redirect
    end

  end

  describe "GET draft" do

    it "redirects to @page" do
      get :draft, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(response).to be_redirect
    end

  end

  describe "DELETE destroy" do

    # Need to recreate after :destroy
    before :each do
      @page = create(:georgia_page)
      @revision = create(:georgia_revision, revisionable: @page)
      @page.current_revision = @revision
      @page.revisions << @revision
      @page.save
    end

    it "redirects to page revisions index" do
      delete :destroy, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(response).to be_redirect
    end

    it "destroys the revision" do
      delete :destroy, use_route: :admin, page_id: @page.id, id: @revision.id
      expect(assigns(:revision).persisted?).to eq false
    end

  end
end