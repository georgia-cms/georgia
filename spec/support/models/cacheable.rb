shared_examples "a cacheable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

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