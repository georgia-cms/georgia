require 'rails_helper'

describe Georgia::Role, type: :model do

  specify {expect(build(:georgia_role)).to be_valid}

  it { expect(subject).to have_and_belong_to_many :users }
  it { expect(subject).to respond_to :name }
  it { expect(subject).to validate_presence_of(:name) }

end