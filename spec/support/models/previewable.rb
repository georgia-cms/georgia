shared_examples "a previewable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

  describe 'actions' do

    it 'should be previewable?' do
      expect(instance.previewable?).to be_true
    end

  end

end