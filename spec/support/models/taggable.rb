shared_examples "a taggable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }

  it { should respond_to :tag_list }

  describe '#tags' do
    it 'returns a list of tags' do
      instance = FactoryGirl.create(model_name, tag_list: 'tag1, tag2, tag3')
      instance.tags.first.should be_a ActsAsTaggableOn::Tag
    end
  end

end