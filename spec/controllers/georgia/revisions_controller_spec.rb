require 'spec_helper'

describe Georgia::RevisionsController do
  include Devise::TestHelpers

  before :all do
    @page = create(:georgia_page)
    @revision = create(:georgia_revision, revisionable: @page)
    @page.current_revision = @revision
    @page.revisions << @revision
    @page.save
  end

  before :each do
    controller.class.skip_before_filter :authenticate_user!
    controller.stub current_user: create(:admin)
  end

  describe "GET index" do

    it "should have a status code of 200" do
      get :index, use_route: :admin, page_id: @page.id
      response.should be_ok
    end

    it "should assign a page" do
      get :index, use_route: :admin, page_id: @page.id
      assigns(:page).should eq @page
    end

    it "should assign revisions" do
      @page.revisions << create(:georgia_revision)
      @page.save
      get :index, use_route: :admin, page_id: @page.id
      assigns(:revisions).should have(1).revision
    end

    it "should assign revisions without current_revision" do
      get :index, use_route: :admin, page_id: @page.id
      assigns(:revisions).should_not include @revision
    end

  end

  describe "GET show" do

    it "should redirect to edit" do
      get :show, use_route: :admin, page_id: @page.id, id: @revision.id
      response.should be_redirect
    end

    it "should assign a page" do
      get :show, use_route: :admin, page_id: @page.id, id: @revision.id
      assigns(:page).should eq @page
    end

    it "should assign a revision" do
      get :show, use_route: :admin, page_id: @page.id, id: @revision.id
      assigns(:revision).should eq @revision
    end

  end

  describe "GET edit" do

    it "should have a status code of 200" do
      get :edit, use_route: :admin, page_id: @page.id, id: @revision.id
      response.should be_ok
    end

    it "should assign a page" do
      get :edit, use_route: :admin, page_id: @page.id, id: @revision.id
      assigns(:page).should eq @page
    end

    it "should assign a revision" do
      get :edit, use_route: :admin, page_id: @page.id, id: @revision.id
      assigns(:revision).should eq @revision
    end

    it "should assign ui_sections" do
      create :georgia_ui_section
      get :edit, use_route: :admin, page_id: @page.id, id: @revision.id
      assigns(:ui_sections).should have(1).ui_section
    end

  end

  describe "PUT update" do

    it "should redirect to edit" do
      put :update, use_route: :admin, page_id: @page.id, id: @revision.id
      response.should be_redirect
    end

    it "should store a new revision" do
      @page.current_revision = @revision
      @page.save
      before_length = @page.revisions.reload.length
      put :update, use_route: :admin, page_id: @page.id, id: @revision.id
      assigns(:page).should have(before_length+1).revisions
    end

  end

  describe "GET review" do

    it "should redirect to edit" do
      get :review, use_route: :admin, page_id: @page.id, id: @revision.id
      response.should be_redirect
    end

  end
  describe "GET approve" do

    it "should redirect to @page" do
      get :approve, use_route: :admin, page_id: @page.id, id: @revision.id
      response.should be_redirect
    end

  end
  describe "GET decline" do

    it "should redirect to edit" do
      get :decline, use_route: :admin, page_id: @page.id, id: @revision.id
      response.should be_redirect
    end

  end
  describe "GET restore" do

    it "should redirect to @page" do
      get :restore, use_route: :admin, page_id: @page.id, id: @revision.id
      response.should be_redirect
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

    it "should redirect to page revisions index" do
      delete :destroy, use_route: :admin, page_id: @page.id, id: @revision.id
      response.should be_redirect
    end

    it "should destroy the revision" do
      delete :destroy, use_route: :admin, page_id: @page.id, id: @revision.id
      assigns(:revision).persisted?.should be_false
    end

  end
end