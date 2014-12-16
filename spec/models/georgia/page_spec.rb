require 'rails_helper'

describe Georgia::Page, type: :model do

  specify {expect(build(:georgia_page)).to be_valid}

  it_behaves_like 'a orderable model'
  it_behaves_like 'a taggable model'
  it_behaves_like 'a treeable model'

  describe 'scopes' do
    describe '.not_self' do
      it "does not return itself" do
        @page = create(:georgia_page)
        expect(Georgia::Page.not_self(@page)).not_to include @page
      end
    end
  end

  it {expect(subject).to allow_value('contact').for(:slug)}
  it {expect(subject).to allow_value('COn-T4CT_').for(:slug)}
  it {expect(subject).to allow_value('/register-me//').for(:slug)}
  it {expect(subject).not_to allow_value('supp/ort').for(:slug).with_message(/can only consist of/)}

  it 'sanitizes the slug by removing the first and last forward slashes' do
    instance = create(:georgia_page, slug: '///leftover//')
    expect(instance.slug).to eq('leftover')
  end


  describe '#url' do

    it 'returns a relative path' do
      page = create(:georgia_page, slug: 'relative')
      expect(page.url).to eq '/relative'
    end

    it "prepares url unless slug_changed? or one of the ancestors' slug changed" do
      page = create(:georgia_page)
      expect(page).to receive(:slug_changed?).once
      expect(page).not_to receive(:update_column)
      page.save
    end

    context 'with ancestry' do

      it 'updates the descendants url' do
        what = create(:georgia_page, slug: 'what')
        who = create(:georgia_page, slug: 'who', parent: what)
        how = create(:georgia_page, slug: 'how', parent: who)
        expect(what.url).to eq  '/what'
        expect(who.url).to  eq  '/what/who'
        expect(how.url).to  eq  '/what/who/how'

        what.slug = 'why'
        what.save!

        # update_column doesn't update rspec variable
        # fetch again to make sure the url has changed
        why = Georgia::Page.find_by_url('/why')
        who = Georgia::Page.find_by_url('/why/who')
        how = Georgia::Page.find_by_url('/why/who/how')

        expect(why.url).to eq '/why'
        expect(who.url).to eq '/why/who'
        expect(how.url).to eq '/why/who/how'
      end

    end

  end

  describe 'caching' do

    let(:instance) { create(:georgia_page) }

    it 'uses the url and the updated_at values to create a cache key' do
      time = Time.now
      instance.stub(:url).and_return('/foo/bar')
      instance.stub(:updated_at).and_return(time)
      expect(instance.cache_key).to eql("/foo/bar/#{time.to_i}")
    end

  end

  describe 'revisioning' do

    it { expect(subject).to have_many :revisions }
    it { expect(subject).to belong_to :current_revision }

    it { expect(subject).to respond_to :publish }
    it { expect(subject).to respond_to :unpublish }
    it { expect(subject).to respond_to :approve_revision }

  end

  describe 'searching' do

    it "responds to .search" do
      expect(Georgia::Page).to respond_to :search
    end

  end

end