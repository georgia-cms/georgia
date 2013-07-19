shared_examples "a revisionable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { FactoryGirl.create(model_name) }

  it { should respond_to :store_as_revision }
  it { should have_many :revisions }

  describe 'storing' do

    it 'duplicates itself to create a new Georgia::Revision' do
      before_instance = instance
      revision = instance.store_as_revision
      expect(revision.persisted?).to be_true
      expect(revision).to be_a Georgia::Revision
      expect(instance).to be eq(before_instance)
    end

  end

end