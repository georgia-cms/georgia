shared_examples "a copyable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

  it { should respond_to :copy }

  it 'should be copyable?' do
    expect(instance.copyable?).to be_true
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
      instance.contents << create(:georgia_content)
      @clone = instance.copy
      expect(@clone.contents.first.title).to match /.*\(Copy\)$/
    end

  end


end