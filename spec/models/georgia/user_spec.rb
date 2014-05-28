require 'spec_helper'

describe Georgia::User do

  specify {build(:georgia_user).should be_valid}

  it {should validate_presence_of(:email)}
  it {should validate_presence_of(:password)}

  it {should belong_to(:role)}

  describe '.name' do

    it "should match the first and last name" do
      user = build(:georgia_user, first_name: 'Bob', last_name: 'Bison')
      user.name.should match 'Bob Bison'
    end

  end

  describe '.role_name' do

    it "delegates to role" do
      user = build(:georgia_user)
      user.role = create(:georgia_role, name: 'Admin')
      user.role_name.should match 'Admin'
    end

  end

end