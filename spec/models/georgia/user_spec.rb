require 'spec_helper'
require 'cancan/matchers'

describe Georgia::User do

  specify {FactoryGirl.build(:georgia_user).should be_valid}

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

    let(:user) { FactoryGirl.build(:georgia_user, roles: [FactoryGirl.build(:georgia_role, name: 'Admin')]) }
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

    let (:admin) { FactoryGirl.create(:admin) }
    let (:editor) { FactoryGirl.create(:editor) }

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

end