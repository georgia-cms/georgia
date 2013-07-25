require 'spec_helper'
require 'cancan/matchers'

describe Georgia::User do

  specify {build(:georgia_user).should be_valid}

  let (:admin) { create(:admin) }
  let (:editor) { create(:editor) }

  it {should allow_mass_assignment_of(:first_name)}
  it {should allow_mass_assignment_of(:last_name)}
  it {should allow_mass_assignment_of(:email)}
  it {should allow_mass_assignment_of(:password)}
  it {should allow_mass_assignment_of(:password_confirmation)}
  it {should allow_mass_assignment_of(:remember_me)}
  it {should allow_mass_assignment_of(:role_ids)}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}

  it {should have_and_belong_to_many(:roles)}

  it {should respond_to :has_role?}

  describe '#has_role?' do

    let(:user) { build(:georgia_user, roles: [build(:georgia_role, name: 'Admin')]) }
    subject { user.has_role? role_name }

    context 'when user has given role' do
      let(:role_name) { 'Admin' }
      it { should be_true }
    end

    context 'when user does not have given role' do
      let(:role_name) { 'Editor' }
      it { should be_false }
    end

  end

  describe 'scopes' do

    before :each do
      Georgia::User.destroy_all
    end

    describe '.admins' do
      subject { Georgia::User.admins }
      it {should include admin}
      it {should_not include editor}
    end
    describe '.editors' do
      subject { Georgia::User.editors }
      it {should include editor}
      it {should_not include admin}
    end
  end

  describe '.publish' do

    before :each do
      @page = create(:georgia_meta_page)
    end

    it "marks a page as published by himself" do
      admin.publish(@page)
      expect(@page.published_by).to eql(admin)
    end

    it "call .publish on page" do
      @page.should_receive :publish
      admin.publish(@page)
    end

  end

  describe '.approve' do

    before :each do
      @page = create(:georgia_review)
    end

    it "marks a page as published by himself" do
      admin.approve(@page)
      expect(@page.published_by).to eql(admin)
    end

    it "call .publish on review" do
      @page.should_receive :publish
      admin.approve(@page)
    end

  end

end