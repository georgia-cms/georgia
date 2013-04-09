require 'spec_helper'

describe Georgia::Content do
  specify {FactoryGirl.build(:content).should be_valid}

  it { should belong_to :image }
  it { should belong_to :contentable }

  it { should ensure_length_of(:title).is_at_most(255) }

end