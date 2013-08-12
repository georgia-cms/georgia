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

      it "returns records in a 'draft' state" do
        admin = create(:admin)
        editor = create(:editor)
        expect(Georgia::User.admins).to eq([admin])
        expect(Georgia::User.admins).not_to include(editor)
      end

    end

    describe '.editors' do

      it "returns records in a 'published' state" do
        admin = create(:admin)
        editor = create(:editor)
        expect(Georgia::User.editors).to eq([editor])
        expect(Georgia::User.editors).not_to include(admin)
      end

    end

  end

end