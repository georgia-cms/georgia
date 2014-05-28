shared_examples "a treeable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

  it { should respond_to :descendants }
  it { should respond_to :children }
  it { should respond_to :root }

end