require 'spec_helper'

describe Georgia::Revision do

  specify {build(:georgia_revision).should be_valid}

  it_behaves_like 'a contentable model'
  it_behaves_like 'a templatable model'

  it { should have_many :slides }
  it { should have_many :widgets }
  it { should belong_to :revisionable }


  describe 'events' do

    describe '#review' do

      it "marks as 'review'" do
        draft = create(:georgia_draft)
        draft.review
        expect(draft.state?(:review)).to be_true
      end

    end

    describe '#approve' do

      it "sets the state to 'published'" do
        review = create(:georgia_review)
        review.revisionable = create(:georgia_page)
        review.approve
        expect(review.state?(:published)).to be_true
      end

      it "makes the revision the 'current_revision'" do
        review = create(:georgia_review)
        review.revisionable = create(:georgia_page)
        review.approve
        expect(review.revisionable.current_revision).to eql(review)
      end

    end

    describe '#store' do
      it "marks as 'revision'" do
        page = create(:georgia_published)
        page.store
        expect(page.state?(:revision)).to be_true
      end

    end

    describe '#restore' do

      it "marks as 'published'" do
        revision = create(:georgia_revision)
        revision.revisionable = create(:georgia_page)
        revision.restore
        expect(revision.state?(:published)).to be_true
      end

    end

    describe '#decline' do

      it "marks as 'draft'" do
        review = create(:georgia_review)
        review.decline
        expect(review.state?(:draft)).to be_true
      end

    end

  end

  describe 'scopes' do

    before :each do
      DatabaseCleaner.clean
    end

    describe '#drafts' do

      it "returns records in a 'draft' state" do
        @draft = create(:georgia_draft)
        @published = create(:georgia_published)
        expect(described_class.drafts).to eq([@draft])
        expect(described_class.drafts).not_to include(@published)
      end
    end

    describe '#published' do

      it "returns records in a 'published' state" do
        @draft = create(:georgia_draft)
        @published = create(:georgia_published)
        expect(described_class.published).to eq([@published])
        expect(described_class.published).not_to include(@draft)
      end

    end

  end

end