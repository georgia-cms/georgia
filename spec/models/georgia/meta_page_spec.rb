require 'spec_helper'

describe Georgia::MetaPage do

  let(:instance) { create(:georgia_meta_page) }

  specify {build(:georgia_meta_page).should be_valid}

  it { should validate_uniqueness_of(:slug).scoped_to(:ancestry) }

  it_behaves_like 'a revisionable model'

  describe 'uuid' do
    it 'creates a new uuid for each newly created page' do
      @page = create(:georgia_meta_page)
      expect(@page.uuid).to match /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
    end
  end

  describe '#draft' do

    it 'starts a new draft of itself' do
      expect(instance).to respond_to :store_as_draft
      instance.store_as_draft
      instance.should have_at_least(1).drafts
    end

  end

  describe '#publish' do

    it "changes the state to 'published'"

  end

  describe '#unpublish' do

    it "changes the state to 'draft'"

  end

end