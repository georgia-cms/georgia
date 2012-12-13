require 'spec_helper'

describe Ckeditor::Picture do

  before :each do
    @picture = FactoryGirl.create(:picture)
  end

  specify {FactoryGirl.build(:picture).should be_valid}

  it {should have_many(:tags)}

  it {should validate_presence_of(:description)}

  describe '.save' do

  end


end