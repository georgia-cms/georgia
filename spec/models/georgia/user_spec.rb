require 'rails_helper'

describe Georgia::User, type: :model do

  specify {expect(build(:georgia_user)).to be_valid}

  it {expect(subject).to validate_presence_of(:email)}
  it {expect(subject).to validate_presence_of(:password)}
  it {expect(subject).to have_many(:roles)}

  describe '#name' do

    it "matches the first and last name" do
      user = build(:georgia_user, first_name: 'Bob', last_name: 'Bison')
      expect(user.name).to eq 'Bob Bison'
    end

  end

  describe '#role_names' do

    it "delegates to role" do
      user = create(:georgia_user, :admin)
      expect(user.role_names).to include 'admin'
    end

  end

end