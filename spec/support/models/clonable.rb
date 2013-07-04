shared_examples "a clonable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }

  it { should respond_to :clone_with_associations }

  describe '#clone_with_associations', focus: true do

    before :each do
      @clonable = FactoryGirl.create(model_name)
    end

    it 'keeps original intact' do
      @original = @clonable.dup
      @clonable.clone_with_associations
      expect(@original.slug).to eql @clonable.slug
    end

    it 'returns a persisted record' do
      @clone = @clonable.clone_with_associations
      expect(@clone.new_record?).to be false
      expect(@clone.eql?(@clonable)).to be false
    end

    it 'adds -copy to slug' do
      @clone = @clonable.clone_with_associations
      expect(@clone.slug).to match /.*-copy/
    end

    it 'adds (Copy) to titles' do
      @clonable.contents << FactoryGirl.create(:georgia_content)
      @clone = @clonable.clone_with_associations
      expect(@clone.contents.first.title).to match /.*\(Copy\)$/
    end

    it 'clones contents' do
      @clonable.contents << FactoryGirl.create(:georgia_content)
      @clone = @clonable.clone_with_associations
      expect(@clone.contents.length).to be 1
      @clone.contents.should_not eql @clonable.contents
    end

    it 'clones widgets' do
      @clonable.ui_associations << FactoryGirl.create(:georgia_ui_association)
      @clonable.ui_associations << FactoryGirl.create(:georgia_ui_association)
      @clone = @clonable.clone_with_associations
      expect(@clone.ui_associations.length).to be 2
    end

    it 'clones slides & its contents' do
      @clonable.slides << FactoryGirl.create(:georgia_slide, contents: [FactoryGirl.create(:georgia_content, title: 'Yeehaw')])
      @clonable.slides << FactoryGirl.create(:georgia_slide)
      @clone = @clonable.clone_with_associations
      expect(@clone.slides.length).to be 2
      expect(@clone.slides.first.contents.first.title).to eql 'Yeehaw'
    end

    it 'clones tags' do
      @clonable.tag_list = "foo, bar"
      @clonable.save!
      @clone = @clonable.clone_with_associations
      expect(@clone.tags).to have(2).tags
      expect(@clone.tag_list).to include 'foo'
    end

    it 'clones keywords' do
      @clonable.contents << FactoryGirl.create(:georgia_content, keyword_list: 'foo, bar, foobar')
      @clone = @clonable.clone_with_associations
      expect(@clone.contents.first.keywords).to have(3).keywords
    end

  end

end