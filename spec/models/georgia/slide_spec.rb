require 'spec_helper'

describe Georgia::Slide do

  specify {FactoryGirl.build(:georgia_slide).should be_valid}

  it { should belong_to :page }
  it { should respond_to :page_id }

  it_behaves_like 'a contentable model'
  it_behaves_like 'a orderable model'

  it 'validates presence of associated page' do
    @slide = FactoryGirl.build(:georgia_slide, page_id: nil)
    @slide.valid?.should be_false
    @slide.should have(1).errors_on(:base)
    expect(@slide.errors_on(:base).first).to eq('An association to a page is required.')
  end

end