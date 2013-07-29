require 'spec_helper'

describe Georgia::Draft do

  let(:instance) { create(:georgia_draft) }

  specify {build(:georgia_draft).should be_valid}

  it_behaves_like 'a clonable model'

  describe 'actions' do

    it 'should be previewable?' do
      expect(instance.previewable?).to be_true
    end
    it 'should be reviewable?' do
      expect(instance.reviewable?).to be_true
    end

  end

end