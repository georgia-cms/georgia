require 'rails_helper'

describe Georgia::Slide, type: :model do

  specify {FactoryGirl.build(:georgia_slide).should be_valid}

  it { should belong_to :revision }
  it { should validate_presence_of(:page_id)}

  it_behaves_like 'a contentable model'
  it_behaves_like 'a orderable model'

end