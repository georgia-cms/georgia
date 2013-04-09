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
  it {should belong_to(:status)}
  it {should have_many(:slides)}

  it {should respond_to(:published?)}
  it {should respond_to(:pending_review?)}
  it {should respond_to(:draft?)}

  it {should respond_to(:publish)}
  it {should respond_to(:unpublish)}
  it {should respond_to(:wait_for_review)}

  it {should validate_uniqueness_of(:slug).scoped_to(:ancestry)}
  it {should allow_value('contact').for(:slug)}
  it {should allow_value('COn-T4CT_').for(:slug)}
  it {should allow_value('/register-me//').for(:slug)} #should sanitize
  it {should allow_value('one-column').for(:template)}
  it {should allow_value('sidebar-left').for(:template)}
  it {should allow_value('sidebar-right').for(:template)}
  it {should_not allow_value('supp/ort').for(:slug).with_message(/can only consist of/)}

  # describe '.publish' do
  #   before { FactoryGirl.create(:status, name: 'Published') }

  #   before :each do
  #     @user = FactoryGirl.create(:user, first_name: 'Mathieu')
  #   end

  #   it "should set a published_by user" do
  #     @page.publish(@user).published_by.should be @user
  #   end
  #   it "should set status to published" do
  #     @page.publish(@user).published?.should be_true
  #   end
  #   it "should create a new revision" do
  #     @page.revision_records.count.should eq 0
  #     @page.publish(@user)
  #     @page.revision_records.count.should eq 1
  #   end
  #   it "should not create a new revision if record is not persisted" do
  #     @page = FactoryGirl.build(:page)
  #     @page.revision_records.count.should eq 0
  #     @page.publish(@user)
  #     @page.revision_records.count.should eq 0
  #   end
  #   it "should store new revision as current revision" do
  #     @page.publish(@user)
  #     @page.last_revision.should == @page.current_revision
  #   end
  #   it "should return self" do
  #     @page.publish(@user).should be @page
  #   end
  # end

  # describe '.unpublish' do
  #   before { FactoryGirl.create(:status, name: 'Draft') }
  #   before :each do
  #     @user = FactoryGirl.create(:user, first_name: 'Mathieu')
  #   end
  #   it "should set a published_by to nil" do
  #     @page.publish(@user).published_by.should be @user
  #     @page.unpublish.published_by.should be_nil
  #   end
  #   it "should set status to draft" do
  #     @page.publish(@user)
  #     @page.unpublish.draft?.should == true
  #   end
  #   it "should set current_revision to nil" do
  #     @page.publish(@user)
  #     @page.unpublish
  #     @page.current_revision.should be_nil
  #   end
  #   it "should return self" do
  #     @page.unpublish.should be @page
  #   end
  # end

  # describe '.wait_for_review' do
  #   before { FactoryGirl.create(:status, name: 'Pending Review') }
  #   before :each do
  #     @user = FactoryGirl.create(:user, first_name: 'Mathieu')
  #   end
  #   it "should set status to pending review" do
  #     @page.wait_for_review.pending_review?.should be_true
  #   end
  #   it "should return self" do
  #     @page.wait_for_review.should be @page
  #   end
  # end

  # describe 'self.published' do
  #   it "should be ordered in time"
  #   it "should only include published articles"
  # end

  # describe 'after_create' do
  #   it "should create a menu item for each available menu"
  # end
  # describe 'before_save' do
  #   it "should default status to draft"
  #   it "should set incomplete status if needed"
  # end

end