shared_examples "a treeable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

  it { expect(subject).to respond_to :descendants }
  it { expect(subject).to respond_to :children }
  it { expect(subject).to respond_to :root }

end