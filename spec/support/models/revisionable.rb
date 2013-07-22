shared_examples "a revisionable model" do

  let(:current_user) { FactoryGirl.build(:georgia_user) }
  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { FactoryGirl.create(model_name) }

  it { should respond_to :store_as_revision }
  it { should respond_to :store_as_review }
  it { should respond_to :store_as_draft }

  it { should have_one :published_page }
  it { should have_many :drafts }
  it { should have_many :reviews }
  it { should have_many :revisions }

  describe 'storing' do

    it 'duplicates itself to create a new Georgia::Revision' do
      instance.store_as_revision
      revision = instance.revisions.first
      expect(revision.persisted?).to be_true
      expect(revision).to be_a Georgia::Revision
    end

  end

  describe 'events' do

    describe 'draft' do

      it { should respond_to :draft }

      it "marks as 'draft'" do
        instance.draft
        expect(instance.state?(:draft)).to be_true
      end

    end

    describe 'ask_for_review' do

      it { should respond_to :ask_for_review }

    end

    describe 'publish' do

      it { should respond_to :publish }

      before :each do
        @observer = Georgia::MetaPageObserver.instance
        @observer.before_publish(instance, nil)
      end

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

      it "stores a new revision" do
        instance.should_receive :store_as_revision
        instance.publish
        instance.should have_at_least(1).revisions
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