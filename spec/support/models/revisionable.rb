shared_examples "a revisionable model" do

  let(:current_user) { build(:georgia_user) }
  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { create(model_name) }

  it { should respond_to :publisher }

  describe 'events' do

    describe 'draft' do

      it { should respond_to :draft }

      it "marks as 'draft'" do
        instance.draft
        expect(instance.state?(:draft)).to be_true
      end

    end

    describe 'publish' do

      it { should respond_to :publish }

      before :each do
        @time_now = Time.parse("Wed, 10 Apr 2013 14:18:22 UTC +00:00")
        Time.stub(:now).and_return(@time_now)
        @observer = Georgia::MetaPageObserver.instance
        @observer.before_publish(instance, nil)
        instance.publish
      end

      it "marks as 'published'" do
        expect(instance.state?(:published)).to be_true
      end

      it "assigns published_at to current time" do
        expect(instance.published_at).to eq(@time_now)
      end

    end

  end

  describe 'scopes' do

    before :each do
      described_class.destroy_all
    end

    it "returns records in a 'draft' state" do
      @draft = FactoryGirl.create(model_name)
      instance.publish
      expect(described_class.with_state(:draft)).to eq([@draft])
      expect(described_class.with_state(:draft)).not_to include(instance)
    end

    it "returns records in a 'published' state" do
      @draft = FactoryGirl.create(model_name)
      instance.publish
      expect(described_class.with_state(:published)).to eq([instance])
      expect(described_class.with_state(:published)).not_to include(@draft)
    end

  end

end