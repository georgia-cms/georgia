require 'spec_helper'

describe Georgia::LinkDecorator do

  subject {Georgia::LinkDecorator.decorate(FactoryGirl.build(:link))}

  it_behaves_like 'a decorator'
  it { should respond_to :url}

  describe '#url' do
    it "returns the value for #text" do
      link = Georgia::LinkDecorator.decorate(FactoryGirl.build(:link))
      link.contents << FactoryGirl.build(:content)
      link.url.should match link.contents.first.text
    end
  end
end