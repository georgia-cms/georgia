require 'spec_helper'

describe Georgia::Page do

  specify {FactoryGirl.build(:georgia_page).should be_valid}

  it_behaves_like 'a orderable model'
  it_behaves_like 'a taggable model'
  it_behaves_like 'a treeable model'

  describe 'scopes' do
    describe '.not_self' do
      it "does not return itself" do
        @page = FactoryGirl.create(:georgia_page)
        expect(Georgia::Page.not_self(@page)).not_to include @page
      end
    end
  end

  it {should allow_value('contact').for(:slug)}
  it {should allow_value('COn-T4CT_').for(:slug)}
  it {should allow_value('/register-me//').for(:slug)}
  it {should_not allow_value('supp/ort').for(:slug).with_message(/can only consist of/)}
  # FIXME: temporary disabled
  # it { should validate_uniqueness_of(:slug).scoped_to(:ancestry) }

  it 'sanitizes the slug by removing the first and last forward slashes' do
    instance = FactoryGirl.create(:georgia_page, slug: '///leftover//')
    expect(instance.slug).to eq('leftover')
  end


  describe  '#url' do

    it 'returns a relative path' do
      page = FactoryGirl.create(:georgia_page, slug: 'relative')
      expect(page.url).to eq '/relative'
    end

    it "prepares url unless slug_changed? or one of the ancestors' slug changed" do
      page = FactoryGirl.create(:georgia_page)
      page.should_receive(:slug_changed?).once
      page.should_not_receive(:update_column)
      page.save
    end

    context 'with ancestry' do

      it 'updates the descendants url' do
        what = FactoryGirl.create(:georgia_page, slug: 'what')
        who = FactoryGirl.create(:georgia_page, slug: 'who', parent: what)
        how = FactoryGirl.create(:georgia_page, slug: 'how', parent: who)
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

    it { should respond_to :cache_key }

    describe '.cache_key' do
      it 'uses the url and the updated_at values to create the key' do
        time = Time.now
        instance.stub(:url).and_return('/foo/bar')
        instance.stub(:updated_at).and_return(time)
        expect(instance.cache_key).to eql("/foo/bar/#{time.to_i}")
      end
    end

  end

  describe 'revisioning' do

    it { should have_many :revisions }
    it { should belong_to :current_revision }

    it { should respond_to :copy }
    it { should respond_to :draft }
    it { should respond_to :store }
    it { should respond_to :approve_revision }

  end

  describe 'indexing' do

    let(:instance) { create(:georgia_page) }

    describe 'searching' do

      it "should respond to .search" do
        Georgia::Page.should respond_to :search
      end

      # FIXME: This example is bound to Tire gem
      # it 'in full text mode by query' do
      #   Georgia::Page.tire.index.delete
      #   Georgia::Page.tire.create_elasticsearch_index
      #   revision = create(:georgia_revision)
      #   revision.contents << build(:georgia_content, title: 'Wise Wiesel')
      #   instance.revisions << revision
      #   instance.current_revision = revision
      #   instance.save
      #   Georgia::Page.tire.index.refresh
      #   search = Georgia::Page.search_index(query: 'Wise')
      #   expect(search.results.first.title).to match 'Wise Wiesel'
      # end

    end

  end

end