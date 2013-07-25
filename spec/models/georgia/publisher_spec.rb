require 'spec_helper'

describe Georgia::Publisher do

  let(:current_user) { build(:georgia_user) }

  before :each do
    @uuid = rand(999999)
    @meta_page = create(:georgia_meta_page, uuid: @uuid, state: :published)
    @review = create(:georgia_review, uuid: @uuid)
    @draft = create(:georgia_draft, uuid: @uuid)
    @revision = create(:georgia_revision, uuid: @uuid)
    @publisher = Georgia::Publisher.new(@uuid)
  end

  describe '#publish' do

    it 'makes the page the MetaPage' do
      @publisher.publish(@review)
      expect(@publisher.meta_page.id).to eql(@review.id)
    end

    it "sets the state of the page to 'published'" do
      expect(@review.published?).to be_false
      @publisher.publish(@review)
      expect(@review.published?).to be_true
    end

    it 'demotes current MetaPage to a Revision' do
      expect(@publisher.revisions.map(&:id)).not_to include(@meta_page.id)
      @publisher.publish(@review)
      expect(@publisher.revisions.map(&:id)).to include(@meta_page.id)
    end

  end

  describe '#unpublish' do

    it "sets the state of the MetaPage to 'draft'" do
      expect(@publisher.published?).to be_true
      @publisher.unpublish
      expect(@publisher.published?).to be_false
      expect(@publisher.meta_page.published?).to be_false
    end

  end

  describe '#review' do

    it 'makes the page the Review' do
      expect(@publisher.reviews.map(&:id)).not_to include(@draft.id)
      @publisher.review(@draft)
      expect(@publisher.reviews.map(&:id)).to include(@draft.id)
    end

    it "sets the state of the page to 'review'" do
      expect(@draft.review?).to be_false
      @publisher.review(@draft)
      expect(@draft.review?).to be_true
    end

  end

  describe '#store' do

    it 'makes the page the Revision' do
      expect(@publisher.revisions.map(&:id)).not_to include(@meta_page.id)
      @publisher.store(@meta_page)
      expect(@publisher.revisions.map(&:id)).to include(@meta_page.id)
    end

    it "sets the state of the page to 'revision'" do
      expect(@meta_page.revision?).to be_false
      @publisher.store(@meta_page)
      expect(@meta_page.revision?).to be_true
    end

  end

  describe 'states' do

    describe 'published?' do

      context 'when a MetaPage is published' do

        it 'is true' do
          @meta_page.publish
          expect(@meta_page.published?).to be_true
          expect(@publisher.published?).to be_true
        end

      end

      context 'when a MetaPage is a draft' do

        it 'is false' do
          @meta_page.unpublish
          expect(@meta_page.published?).to be_false
          expect(@publisher.published?).to be_false
        end

      end

      context 'when there are no published MetaPage' do

        it 'is false' do
          publisher = Georgia::Publisher.new(rand(999999))
          expect(publisher.published?).to be_false
        end

      end

    end

  end

  describe 'associations' do

    it 'has one meta_page' do
      expect(@publisher.meta_page).to eql(@meta_page)
    end

    it 'has many pages' do
      expect(@publisher.pages).to include(@review)
      expect(@publisher.pages).to include(@draft)
      expect(@publisher.pages).to include(@revision)
      expect(@publisher.pages).to include(@meta_page)
    end

    it 'has many drafts' do
      expect(@publisher.drafts).to include(@draft)
      expect(@publisher.drafts).not_to include(@review)
    end

    it 'has many reviews' do
      expect(@publisher.reviews).to include(@review)
      expect(@publisher.reviews).not_to include(@revision)
    end

    it 'has many revisions' do
      expect(@publisher.revisions).to include(@revision)
      expect(@publisher.revisions).not_to include(@meta_page)
    end

  end

end