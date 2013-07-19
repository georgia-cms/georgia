shared_examples "a clonable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { FactoryGirl.create(model_name) }

  it { should respond_to :copy }
  it { should respond_to :clone }


  describe 'cloning' do

    it 'keeps original intact' do
      @clone = instance.clone
      expect(@clone.slug).to eql instance.slug
    end

    it 'duplicates contents' do
      instance.contents << FactoryGirl.create(:georgia_content)
      @clone = instance.clone
      expect(@clone.contents.length).to be 1
      expect(@clone.contents.first.title).to eql instance.contents.first.title
    end

    it 'duplicates widgets' do
      instance.ui_associations << FactoryGirl.create(:georgia_ui_association)
      instance.ui_associations << FactoryGirl.create(:georgia_ui_association)
      @clone = instance.clone
      expect(@clone.ui_associations.length).to be 2
    end

    it 'duplicates slides & its contents' do
      instance.slides << FactoryGirl.create(:georgia_slide, contents: [FactoryGirl.create(:georgia_content, title: 'Yeehaw')])
      instance.slides << FactoryGirl.create(:georgia_slide)
      @clone = instance.clone
      expect(@clone.slides.length).to be 2
      expect(@clone.slides.first.contents.first.title).to eql 'Yeehaw'
    end

    it 'duplicates tags' do
      instance.tag_list = "foo, bar"
      instance.save!
      @clone = instance.clone
      expect(@clone.tag_list).to include 'foo'
      expect(@clone.tags).to have(2).tags
    end

    it 'duplicates keywords' do
      instance.contents << FactoryGirl.create(:georgia_content, keyword_list: 'foo, bar, foobar')
      @clone = instance.clone
      expect(@clone.contents.first.keywords).to have(3).keywords
    end

  end

  describe 'copying' do

    it 'returns a persisted record' do
      @clone = instance.copy
      expect(@clone.new_record?).to be false
      expect(@clone.eql?(instance)).to be false
    end

    it 'adds -copy to slug' do
      @clone = instance.copy
      expect(@clone.slug).to match /.*-copy/
    end

    it 'adds (Copy) to titles' do
      instance.contents << FactoryGirl.create(:georgia_content)
      @clone = instance.copy
      expect(@clone.contents.first.title).to match /.*\(Copy\)$/
    end

  end

end