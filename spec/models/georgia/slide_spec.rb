require 'rails_helper'

describe Georgia::Slide, type: :model do

  specify {expect(build(:georgia_slide)).to be_valid}

  it { is_expected.to belong_to :revision }
  it { is_expected.to validate_presence_of(:page_id)}

  it_behaves_like 'a contentable model'
  it_behaves_like 'a orderable model'

end