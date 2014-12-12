shared_examples "a taggable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }

  it { expect(subject).to respond_to :tag_list }

  describe '#tags' do
    it 'returns a list of tags' do
      instance = FactoryGirl.create(model_name, tag_list: 'tag1, tag2, tag3')
      expect(instance.tags.first).to be_a ActsAsTaggableOn::Tag
    end
  end

end