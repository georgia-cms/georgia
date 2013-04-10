shared_examples "a publishable model" do

  it { should respond_to :published?, :pending_review?, :draft? }
  it { should respond_to :publish, :unpublish, :wait_for_review }

  it { should belong_to :status }
  it { should belong_to :published_by }


  before do
    FactoryGirl.create(:georgia_status, name: 'Published')
    FactoryGirl.create(:georgia_status, name: 'Draft')
    FactoryGirl.create(:georgia_status, name: 'Pending Review')
  end

  let(:current_user) { FactoryGirl.build(:georgia_user) }
  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }
  let(:instance) { FactoryGirl.build(model_name) }

  describe '.publish' do

    it "should set a published_by user" do
      expect(instance.publish(current_user).published_by).to eq(current_user)
    end

    it "should set published_at" do
      @time_now = Time.parse("Wed, 10 Apr 2013 14:18:22 UTC +00:00")
      Time.stub!(:now).and_return(@time_now)
      expect(instance.publish(current_user).published_at).to eq(@time_now)
    end

    it "should set status to published" do
      instance.publish(current_user).published?.should be_true
    end

    it "should not create a new revision if record is not persisted" do
      expect(instance.revision_records.count).to eq(0)
      instance.publish(current_user)
      expect(instance.revision_records.count).to eq(0)
    end

    it "should return self" do
      instance.publish(current_user).should be instance
    end

  end

  describe '.unpublish' do

    it "should set status to draft" do
      instance.publish(current_user)
      expect(instance.unpublish.draft?).to be_true
    end

    it "should return self" do
      instance.unpublish.should be instance
    end

  end

  describe '.wait_for_review' do

    it "should set status to pending review" do
      instance.wait_for_review
      expect(instance.status.name).to eq('Pending Review')
      expect(instance.pending_review?).to be_true
    end

    it "should return self" do
      instance.wait_for_review.should be instance
    end

  end

  describe 'scopes' do

    describe 'published' do
      it "returns records where status is 'Published'" do
        described_class.destroy_all
        @published = FactoryGirl.create(model_name, status: FactoryGirl.build(:georgia_status, name: 'Published'))
        FactoryGirl.create(model_name, status: FactoryGirl.build(:georgia_status, name: 'Draft'))
        expect(described_class.published).to eq([@published])
      end
    end

    describe 'draft' do
      it "returns records where status is 'Draft'" do
        described_class.destroy_all
        @draft = FactoryGirl.create(model_name, status: FactoryGirl.build(:georgia_status, name: 'Draft'))
        FactoryGirl.create(model_name, status: FactoryGirl.build(:georgia_status, name: 'Pending Review'))
        expect(described_class.draft).to eq([@draft])
      end
    end

    describe 'pending_review' do
      it "returns records where status is 'Pending Review'" do
        described_class.destroy_all
        @pending_review = FactoryGirl.create(model_name, status: FactoryGirl.build(:georgia_status, name: 'Pending Review'))
        FactoryGirl.create(model_name, status: FactoryGirl.build(:georgia_status, name: 'Draft'))
        expect(described_class.pending_review).to eq([@pending_review])
      end
    end

  end

end