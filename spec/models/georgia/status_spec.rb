require 'spec_helper'

describe Georgia::Status do

  specify {FactoryGirl.build(:georgia_status).should be_valid}

  it { should respond_to :name, :label, :icon }

  it {should respond_to(:published?)}
  it {should respond_to(:draft?)}
  it {should respond_to(:pending_review?)}

  it {should validate_presence_of(:name)}

  describe 'status booleans' do

    let(:status) { FactoryGirl.build(:georgia_status, name: status_name) }

    describe '#published?' do

      subject { status.published? }

      context "when status is published" do
        let(:status_name) { 'Published' }
        it { should be_true }
      end

      context 'when status is not published' do
        let(:status_name) { 'Foo Bar' }
        it { should be_false }
      end

    end

    describe '#draft?' do

      subject { status.draft? }

      context "when status is draft" do
        let(:status_name) { 'Draft' }
        it { should be_true }
      end

      context 'when status is not draft' do
        let(:status_name) { 'Foo Bar' }
        it { should be_false }
      end

    end

    describe '#pending_review?' do

      subject { status.pending_review? }

      context "when status is pending review" do
        let(:status_name) { 'Pending Review' }
        it { should be_true }
      end

      context 'when status is not pending_review' do
        let(:status_name) { 'Foo Bar' }
        it { should be_false }
      end

    end

  end

end