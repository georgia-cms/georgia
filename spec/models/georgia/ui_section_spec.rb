require 'spec_helper'

describe Georgia::UiSection do

  specify {FactoryGirl.build(:georgia_ui_section).should be_valid}

  it { should have_many(:ui_associations) }
  it { should have_many(:widgets) }
  it { should have_many(:pages) }

  it { should respond_to :name }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

end