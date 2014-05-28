require 'spec_helper'

describe Georgia::Role do

  specify {FactoryGirl.build(:georgia_role).should be_valid}

  it { should have_many :users }

  it { should respond_to :name }

  it {should validate_presence_of(:name)}

end