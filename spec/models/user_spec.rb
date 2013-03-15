require 'spec_helper'
require 'cancan/matchers'

describe Georgia::User do

  specify {FactoryGirl.build(:user).should be_valid}

  it {should allow_mass_assignment_of(:first_name)}
  it {should allow_mass_assignment_of(:last_name)}
  it {should allow_mass_assignment_of(:email)}
  it {should allow_mass_assignment_of(:password)}
  it {should allow_mass_assignment_of(:password_confirmation)}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}

  it {should have_and_belong_to_many(:roles)}

  it {should respond_to :has_role?}
  it {should respond_to :name}

  describe '.name' do

    it "should match the first and last name" do
      user = FactoryGirl.build(:user, first_name: 'Bob', last_name: 'Bison')
      user.name.should match 'Bob Bison'
    end

  end

  describe 'abilities' do

    subject { ability }
    let(:ability){Ability.new(user)}

    context "when is an admin" do
      user = FactoryGirl.build(:user)
      user.roles << FactoryGirl.build(:admin_role)
      let(:user){user}
      it{should be_able_to(:manage, :all)}
    end

    context "when is an editor" do
      user = FactoryGirl.build(:user)
      user.roles << FactoryGirl.build(:editor_role)
      let(:user){user}
      it{should be_able_to(:publish, :all)}
    end

    context "when is a comm spec" do
      user = FactoryGirl.build(:user)
      user.roles << FactoryGirl.build(:comm_role)
      let(:user){user}

      it{should_not be_able_to(:manage, :all)}
      it{should_not be_able_to(:publish, :all)}

      it{should be_able_to(:read, Page)}
      it{should be_able_to(:create, Page)}
      it{should be_able_to(:update, Page)}
      it{should be_able_to(:ask_for_review, Page)}
      it{should be_able_to(:read, Partner)}
      it{should be_able_to(:create, Partner)}
      it{should be_able_to(:update, Partner)}
      it{should be_able_to(:ask_for_review, Partner)}
    end

    context "when is a hr" do
      user = FactoryGirl.build(:user)
      user.roles << FactoryGirl.build(:hr_role)
      let(:user){user}
      it{should_not be_able_to(:manage, :all)}

      it{should be_able_to(:read, JobOffer)}
      it{should be_able_to(:create, JobOffer)}
      it{should be_able_to(:update, JobOffer)}
      it{should be_able_to(:ask_for_review, JobOffer)}
      it{should_not be_able_to(:publish, JobOffer)}
      it{should be_able_to(:unpublish, JobOffer)}

      it{should be_able_to(:read, Candidate)}
      it{should_not be_able_to(:manage, Candidate)}

      it{should be_able_to(:read, Ckeditor::Asset)}
      it{should be_able_to(:create, Ckeditor::Asset)}
      it{should_not be_able_to(:destroy, Ckeditor::Asset)}
      it{should_not be_able_to(:manage, Ckeditor::Asset)}

    end

  end

end
