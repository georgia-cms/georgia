shared_examples "a statable model" do

  let(:current_user) { FactoryGirl.build(:georgia_user) }
  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { FactoryGirl.create(model_name) }

  describe 'events' do

    describe 'draft' do

      it { should respond_to :draft }

      it "marks as 'draft'" do
        instance.draft
        expect(instance.state?(:draft)).to be_true
      end

    end

    describe 'pending_review' do

      it { should respond_to :ask_for_review }

      it "marks as 'pending review'" do
        instance.ask_for_review
        expect(instance.state?(:pending_review)).to be_true
      end

    end

    describe 'publish' do

      it { should respond_to :publish }

      it "marks as 'published'" do
        instance.publish
        expect(instance.state?(:published)).to be_true
      end

      it "assigns published_at to current time" do
        @time_now = Time.parse("Wed, 10 Apr 2013 14:18:22 UTC +00:00")
        Time.stub!(:now).and_return(@time_now)
        instance.publish
        expect(instance.published_at).to eq(@time_now)
      end

    end

  end

  describe 'scopes' do

    before :all do
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

    it "returns records in a 'pending_review' state" do
      @draft = FactoryGirl.create(model_name)
      instance.ask_for_review
      expect(described_class.with_state(:pending_review)).to eq([instance])
      expect(described_class.with_state(:pending_review)).not_to include(@draft)
    end

  end

end