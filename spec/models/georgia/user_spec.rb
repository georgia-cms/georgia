require 'spec_helper'
require 'cancan/matchers'

describe Georgia::User do

  specify {FactoryGirl.build(:georgia_user).should be_valid}

  it {should allow_mass_assignment_of(:first_name)}
  it {should allow_mass_assignment_of(:last_name)}
  it {should allow_mass_assignment_of(:email)}
  it {should allow_mass_assignment_of(:password)}
  it {should allow_mass_assignment_of(:password_confirmation)}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}

  it {should have_and_belong_to_many(:roles)}

  it {should respond_to :has_role?}

  describe 'abilities' do

    subject { ability }

    let(:ability) { Ability.new(user) }

    context "when is an admin" do
      let(:user){ FactoryGirl.build(:admin) }
      it { should be_able_to(:manage, :all) }
    end

    context "when is an editor" do
      let(:user) { FactoryGirl.build(:editor) }
      it { should be_able_to(:publish, :all) }
    end

  end

end
