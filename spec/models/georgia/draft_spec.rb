require 'spec_helper'

describe Georgia::Draft do

  it { should belong_to :meta_page }

  it { should respond_to :ask_for_review }
  it { should respond_to :wait_for_review }

  describe '.ask_for_review' do

    it 'draft becomes a review' do
      draft = create(:georgia_draft)
      revision = draft.ask_for_review
      expect(revision).to be_a Georgia::Review
    end

  end

  it_behaves_like 'a storable model'

end