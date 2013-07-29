shared_examples "a clonable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

  it { should respond_to :clone }

  it 'should be clonable?' do
    expect(instance.clonable?).to be_true
  end

end