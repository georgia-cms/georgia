require 'spec_helper'

describe Georgia::Page do
  before :each do
    @page = FactoryGirl.create(:page)
  end

  specify {FactoryGirl.build(:page).should be_valid}

  it {should have_many(:contents)}
  it {should have_many(:ui_associations)}
  it {should have_many(:ui_sections)}
  it {should have_many(:widgets)}
  it {should belong_to(:published_by)}
  it {should belong_to(:parent)}
  it {should have_many(:children)}
  it {should have_many(:menu_items)}
  it {should have_one(:status)}
  it {should have_many(:slides)}

  it {should respond_to(:published?)}
  it {should respond_to(:pending_review?)}
  it {should respond_to(:draft?)}

  it {should respond_to(:publish)}
  it {should respond_to(:unpublish)}
  it {should respond_to(:wait_for_review)}

  it {should validate_uniqueness_of(:slug).scoped_to(:parent_id)}
  it {should validate_format_of(:template).with('one-column')}
  it {should validate_format_of(:template).with('sidebar-left')}
  it {should validate_format_of(:template).with('sidebar-right')}
  it {should validate_format_of(:template).with('contact')}

  describe '.publish' do
    before { FactoryGirl.create(:status, name: 'Published') }
    before :each do
      @user = FactoryGirl.create(:user, first_name: 'Mathieu')
    end
    it "should set a published_at date" do
      @page.publish(@user).published_at.should_not be_nil
    end
    it "should set a published_by user" do
      @page.publish(@user).published_by.should be @user
    end
    it "should set status to published" do
      @page.publish(@user).published?.should be_true
    end
    it "should return self" do
      @page.publish(@user).should be @page
    end
  end

  describe '.unpublish' do
    before { FactoryGirl.create(:status, name: 'Draft') }
    before :each do
      @user = FactoryGirl.create(:user, first_name: 'Mathieu')
    end
    it "should set a published_at to nil" do
      @page.publish(@user)
      @page.publish(@user).published_at.should_not be_nil
      @page.unpublish.published_at.should be_nil
    end
    it "should set a published_by to nil" do
      @page.publish(@user).published_by.should be @user
      @page.unpublish.published_by.should be_nil
    end
    it "should set status to draft" do
      @page.unpublish.draft?.should be_true
    end
    it "should return self" do
      @page.unpublish.should be @page
    end
  end

  describe '.wait_for_review' do
    before { FactoryGirl.create(:status, name: 'Pending Review') }
    before :each do
      @user = FactoryGirl.create(:user, first_name: 'Mathieu')
    end
    it "should not set published_at" do
      @page.publish(@user).published_at.should_not be_nil
      date = @page.published_at
      @page.wait_for_review.published_at.should == date
      @page.unpublish.wait_for_review.published_at.should be_nil
    end
    it "should not set a published_by" do
      @page.publish(@user).published_by.should_not be_nil
      @page.wait_for_review.published_by.should be @user
      @page.unpublish.wait_for_review.published_by.should be_nil
    end
    it "should set status to pending review" do
      @page.wait_for_review.pending_review?.should be_true
    end
    it "should return self" do
      @page.wait_for_review.should be @page
    end
  end

  describe 'self.published' do
    it "should be ordered in time"
    it "should only include published articles"
  end

  describe 'after_create' do
    it "should create a menu item for each available menu"
  end
  describe 'before_save' do
    it "should default status to draft"
    it "should set incomplete status if needed"
  end

end