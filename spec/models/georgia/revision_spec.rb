require 'rails_helper'

describe Georgia::Revision, type: :model do

  specify {expect(build(:georgia_revision)).to be_valid}

  it_behaves_like 'a contentable model'

  it { is_expected.to have_many :slides }
  it { is_expected.to have_many :widgets }
  it { is_expected.to belong_to :revisionable }

  describe 'status' do
    it 'defaults to "draft"' do
      expect(Georgia::Revision.new.status).to eq "draft"
    end
  end

  describe 'scopes' do

    before :each do
      DatabaseCleaner.clean
      @draft = create(:georgia_revision, :draft)
      @published = create(:georgia_revision, :published)
    end

    describe '#drafts' do
      it "returns records in a 'draft' state" do
        drafts = Georgia::Revision.draft.to_a
        expect(drafts).to eq([@draft])
        expect(drafts).not_to include(@published)
      end
    end

    describe '#published' do
      it "returns records in a 'published' state" do
        published_revisions = Georgia::Revision.published.to_a
        expect(published_revisions).to eq([@published])
        expect(published_revisions).not_to include(@draft)
      end
    end

  end

  describe 'templates' do
    it { is_expected.to allow_value('default').for(:template) }
    it { is_expected.not_to allow_value('foobar').for(:template) }
  end

end