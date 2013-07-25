require 'spec_helper'

describe Georgia::Draft do

  it { should belong_to :meta_page }

  it { should respond_to :ask_for_review }
  it { should respond_to :wait_for_review }

  describe '.ask_for_review' do

    it 'draft becomes a review' do
      draft = create(:georgia_draft)
      review = draft.ask_for_review
      expect(review).to be_a Georgia::Review
    end

  end

  it_behaves_like 'a storable model'

end