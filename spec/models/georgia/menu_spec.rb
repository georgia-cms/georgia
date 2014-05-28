require 'spec_helper'

describe Georgia::Menu do
  specify {FactoryGirl.build(:georgia_menu).should be_valid}

  it { should have_many :links }

  it { should respond_to :name }

end