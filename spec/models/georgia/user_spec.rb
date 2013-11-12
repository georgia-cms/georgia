require 'spec_helper'
require 'cancan/matchers'

describe Georgia::User do

  specify {build(:georgia_user).should be_valid}

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

  describe '.has_role?' do

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

  describe '.name' do

    it "should match the first and last name" do
      user = build(:georgia_user, first_name: 'Bob', last_name: 'Bison')
      user.name.should match 'Bob Bison'
    end

  end

  describe '.roles_names' do

    it "returns a comma-separated list of roles" do
      user = build(:georgia_user)
      user.roles << create(:georgia_role, name: 'Admin')
      user.roles << create(:georgia_role, name: 'Editor')
      user.roles_names.should match 'Admin, Editor'
    end

  end

end