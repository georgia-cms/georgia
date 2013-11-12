shared_examples "a revisionable model" do

  let(:current_user) { build(:georgia_user) }
  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

  it { should have_many :revisions }
  it { should belong_to :current_revision }

  it { should respond_to :copy }
  it { should respond_to :draft }
  it { should respond_to :store }
  it { should respond_to :approve_revision }

end