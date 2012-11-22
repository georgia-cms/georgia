require 'spec_helper'

describe Georgia::Status do

  specify {FactoryGirl.build(:status).should be_valid}

  it {should have_many(:pages)}

  it {should respond_to(:published?)}
  it {should respond_to(:pending_review?)}
  it {should respond_to(:draft?)}

  context "when status is published" do
    before { @status = FactoryGirl.build(:status, name: 'Published') }
    it "should be published?" do
      @status.published?.should be_true
    end
    it "should not be draft?" do
      @status.draft?.should be_false
    end
    it "should not be pending_review?" do
      @status.pending_review?.should be_false
    end
  end
  context "when status is draft" do
    before { @status = FactoryGirl.build(:status, name: 'Draft') }
    it "should not be published?" do
      @status.published?.should be_false
    end
    it "should be draft?" do
      @status.draft?.should be_true
    end
    it "should not be pending_review?" do
      @status.pending_review?.should be_false
    end
  end
  context "when status is pending review" do
    before { @status = FactoryGirl.build(:status, name: 'Pending Review') }
    it "should not be published?" do
      @status.published?.should be_false
    end
    it "should not be draft?" do
      @status.draft?.should be_false
    end
    it "should be pending_review?" do
      @status.pending_review?.should be_true
    end
  end

end