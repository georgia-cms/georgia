require 'spec_helper'


describe Georgia::Page do

  specify {FactoryGirl.build(:georgia_page).should be_valid}

  it {should have_many(:slides)}
  it {should have_many(:widgets)}
  it {should belong_to(:created_by)}
  it {should belong_to(:updated_by)}

  it {should validate_uniqueness_of(:slug).scoped_to(:ancestry)}
  it {should allow_value('contact').for(:slug)}
  it {should allow_value('COn-T4CT_').for(:slug)}
  it {should allow_value('/register-me//').for(:slug)} #should sanitize
  it {should allow_value('one-column').for(:template)}
  it {should allow_value('sidebar-left').for(:template)}
  it {should allow_value('sidebar-right').for(:template)}
  it {should_not allow_value('supp/ort').for(:slug).with_message(/can only consist of/)}

  it_behaves_like 'a publishable model'
  it_behaves_like 'a revisionable model'
  it_behaves_like 'a contentable model'
  it_behaves_like 'a previewable model'
  it_behaves_like 'a searchable model'
  it_behaves_like 'a taggable model'
  it_behaves_like 'a slugable model'
  it_behaves_like 'a templatable model'
  it_behaves_like 'a orderable model'

  describe 'scopes' do
    describe '.not_self' do
      it "does not return itself"
    end
  end

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