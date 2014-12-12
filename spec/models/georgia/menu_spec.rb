require 'rails_helper'

describe Georgia::Menu, type: :model do
  specify {build(:georgia_menu).should be_valid}

  it { should have_many :links }

  it { should respond_to :name }

end