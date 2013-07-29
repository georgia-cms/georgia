require 'spec_helper'

describe Georgia::Clone do

  let(:instance) { create(:georgia_draft) }

  describe 'cloning' do

    it 'keeps original intact' do
      @clone = instance.clone
      expect(@clone.slug).to eql instance.slug
    end

    it 'duplicates contents' do
      instance.contents << create(:georgia_content)
      @clone = instance.clone
      @clone.should have(1).contents
      expect(@clone.contents.first.title).to eql instance.contents.first.title
    end

    it 'duplicates widgets' do
      instance.ui_associations << create(:georgia_ui_association)
      instance.ui_associations << create(:georgia_ui_association)
      @clone = instance.clone
      @clone.should have(2).ui_associations
    end

    it 'duplicates slides & its contents' do
      instance.slides << create(:georgia_slide, contents: [create(:georgia_content, title: 'Yeehaw')])
      instance.slides << create(:georgia_slide)
      @clone = instance.clone
      @clone.should have(2).slides
      expect(@clone.slides.first.contents.first.title).to eql 'Yeehaw'
    end

    it 'duplicates tags' do
      instance.tag_list = "foo, bar"
      instance.save!
      @clone = instance.clone
      expect(@clone.tag_list).to include 'foo'
      Georgia::Draft.tagged_with(['foo', 'bar']).to_a.should include(@clone)
      expect(@clone.tags).to have(2).tags
    end

    describe 'contents' do

      it 'duplicates keywords' do
        instance.contents << create(:georgia_content, keyword_list: 'foo, bar, foobar')
        expect(instance.contents.first.keywords).to have(3).keywords
        @clone = instance.clone
        content = @clone.contents.first
        expect(content.keyword_list).to include('foo')
        expect(content.keyword_list).to include('bar')
        expect(content.keyword_list).to include('foobar')
        expect(content.keywords).to have(3).keywords
      end

    end

  end

end