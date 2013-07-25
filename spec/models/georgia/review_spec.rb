require 'spec_helper'

describe Georgia::Review do

  let(:current_user) { build(:georgia_user) }

  it { should belong_to :meta_page }

  it_behaves_like 'a storable model'

  describe '#approve' do

    it 'becomes a MetaPage' do
      review = create(:georgia_review)
      page = current_user.approve(review)
      expect(page).to be_a Georgia::MetaPage
    end

    it "state is 'published'" do
      review = create(:georgia_review)
      current_user.approve(review)
      expect(review.published?).to be_true
    end

    it 'demotes current MetaPage to a Revision'
    # it 'demotes current MetaPage to a Revision' do
    #   review = create(:georgia_review, uuid: '1234')
    #   meta_page = create(:georgia_meta_page, uuid: '1234')
    #   expect(review.meta_page).to eql(meta_page)
    #   current_user.approve(review)
    #   expect(meta_page).to be_a Georgia::Revision
    # end

  end

end