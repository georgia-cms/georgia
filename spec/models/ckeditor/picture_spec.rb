require 'spec_helper'

describe Ckeditor::Picture do

  # specify {FactoryGirl.build(:picture).should be_valid}

  it {should have_many(:tags)}

end