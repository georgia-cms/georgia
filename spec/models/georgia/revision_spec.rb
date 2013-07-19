require 'spec_helper'

describe Georgia::Revision do

  it { should belong_to :page }

  describe '#store' do

    it "creates a new revision" do
      @page = FactoryGirl.create(:georgia_page)
      @revision = Georgia::Revision.store(@page)
      expect(@revision).to be_a Georgia::Revision
      expect(@revision).to be_valid
    end

    it "duplicates an exact copy" do
      @page = FactoryGirl.create(:georgia_page)
      @revision = Georgia::Revision.store(@page)
      @revision.save!
      expect(@page.slug).to eql(@revision.slug)
    end

  end

end