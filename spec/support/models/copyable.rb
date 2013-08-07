shared_examples "a copyable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

  it { should respond_to :copy }

  it 'should be copyable?' do
    expect(instance.copyable?).to be_true
  end

end