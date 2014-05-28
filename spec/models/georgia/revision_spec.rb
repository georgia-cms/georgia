require 'spec_helper'

describe Georgia::Revision do

  specify {build(:georgia_revision).should be_valid}

  it_behaves_like 'a contentable model'

  it { should have_many :slides }
  it { should have_many :widgets }
  it { should belong_to :revisionable }

  describe 'status' do
    it 'defaults to "draft"' do
      expect(Georgia::Revision.new.status).to eq "draft"
    end
  end

  describe 'events' do

    before :each do
      @revision = build(:georgia_revision)
    end

    describe '#review' do
      it "sets the status to 'review'" do
        @revision.review
        expect(@revision.status).to eq "review"
      end
    end

    describe '#approve' do

      it "sets the status to 'published'" do
        @revision.revisionable = create(:georgia_page)
        @revision.approve
        expect(@revision.status).to eq "published"
      end

      it "makes the revision the 'current_revision'" do
        @revision.revisionable = create(:georgia_page)
        @revision.approve
        expect(@revision.revisionable.current_revision).to eql(@revision)
      end

    end

    describe '#store' do
      it "sets the status to 'revision'" do
        @revision.store
        expect(@revision.status).to eq "revision"
      end
    end

    describe '#restore' do
      it "sets the status to 'published'" do
        @revision.revisionable = create(:georgia_page)
        @revision.restore
        expect(@revision.status).to eq "published"
      end
    end

    describe '#decline' do
      it "sets the status to 'draft'" do
        @revision.decline
        expect(@revision.status).to eq "draft"
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
        drafts = Georgia::Revision.draft.to_a
        expect(drafts).to eq([@draft])
        expect(drafts).not_to include(@published)
      end
    end

    describe '#published' do
      it "returns records in a 'published' state" do
        @draft = create(:georgia_draft)
        @published = create(:georgia_published)
        published_revisions = Georgia::Revision.published.to_a
        expect(published_revisions).to eq([@published])
        expect(published_revisions).not_to include(@draft)
      end
    end

  end

  describe 'templates' do
    it { should allow_value('one-column').for(:template) }
    it { should allow_value('sidebar-left').for(:template)}
    it { should allow_value('sidebar-right').for(:template)}
    it { should_not allow_value('foobar').for(:template) }
  end

end