require 'rails_helper'

describe Georgia::Clone, broken: true do

  let(:instance) { create(:georgia_page) }

  describe 'instance methods' do

    let(:georgia_page) { create(:georgia_page) }
    let(:subject) { Georgia::Clone.new(georgia_page) }

    it "responds to :copy" do
      expect(subject).to respond_to(:copy)
    end

    it "responds to :draft" do
      expect(subject).to respond_to(:draft)
    end

    it "responds to :store" do
      expect(subject).to respond_to(:store)
    end

  end

  describe 'copying' do

    it 'returns a persisted record' do
      @copy = subject.copy
      expect(@copy.new_record?).to be false
      expect(@copy.eql?(instance)).to be false
    end

    it 'adds -copy to slug' do
      @copy = subject.copy
      expect(@copy.slug).to match /.*-copy/
    end

    it 'adds (Copy) to titles' do
      instance.current_revision = create(:georgia_published)
      instance.current_revision.contents << create(:georgia_content)
      @copy = subject.copy
      expect(@copy.current_revision.contents.first.title).to match /.*\(Copy\)$/
    end

    it 'duplicates contents' do
      instance.current_revision.contents = [create(:georgia_content, text: 'Yabadabadoo')]
      expect(instance.current_revision).to have(1).contents
      @copy = subject.copy
      expect(@copy.current_revision).to have(1).contents
      expect(@copy.current_revision.contents.first.text).to eq "Yabadabadoo"
    end

    it 'duplicates widgets' do
      instance.current_revision.ui_associations << create(:georgia_ui_association)
      instance.current_revision.ui_associations << create(:georgia_ui_association)
      @copy = subject.copy
      expect(@copy.current_revision).to have(2).ui_associations
    end

    it 'duplicates slides & its contents' do
      instance.current_revision.slides << create(:georgia_slide, contents: [create(:georgia_content, text: 'Yeehaw')])
      instance.current_revision.slides << create(:georgia_slide)
      @copy = subject.copy
      expect(@copy.current_revision).to have(2).slides
      expect(@copy.current_revision.slides.first.contents.first.text).to eql 'Yeehaw'
    end

    it 'duplicates tags' do
      instance.tag_list = "foo, bar"
      instance.save!
      @copy = subject.copy
      expect(@copy.tag_list).to include 'foo'
      expect(Georgia::Page.tagged_with(['foo', 'bar']).to_a).to include(@copy)
      expect(@copy.tags).to have(2).tags
    end

    describe 'contents' do

      it 'duplicates keywords' do
        instance.current_revision.contents = [create(:georgia_content, keyword_list: 'foo, bar')]
        expect(instance.current_revision.contents.first.keywords).to have(2).keywords
        @copy = instance.copy
        content = @copy.current_revision.contents.first
        expect(content.keyword_list).to include('foo')
        expect(content.keyword_list).to include('bar')
        expect(content.keywords).to have(2).keywords
      end

    end

  end

end