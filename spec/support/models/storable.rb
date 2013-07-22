shared_examples "a storable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:association) { described_class.name.underscore.gsub(/georgia\/(.*)/, '\1').pluralize.to_sym }
  let(:instance) { FactoryGirl.create(:georgia_meta_page) }

  it { described_class.should respond_to :store }

  describe '.store' do

    before :each do
      described_class.store(instance)
    end

    it "creates a new copy" do
      instance.should have_at_least(1).send(association)
      expect(instance.send(association).first).to be_a described_class
    end

    it "duplicates an exact copy" do
      expect(instance.slug).to eql(instance.send(association).first.slug)
    end

    it 'shares the same uuid' do
      expect(instance.uuid).to eql(instance.send(association).first.uuid)
    end

  end

end