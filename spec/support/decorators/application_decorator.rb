shared_examples "a decorator" do

  let(:instance) { Georgia::ApplicationDecorator.decorate(create(:georgia_page)) }
  let(:current_user) { build(:georgia_user, first_name: 'Bob', last_name: 'Baboon') }

  it {should respond_to(:pretty_created_at)}
  it {should respond_to(:pretty_updated_at)}
  it {should respond_to(:created_by_name)}
  it {should respond_to(:updated_by_name)}

  before :each do
    @time_now = Time.parse("Wed, 10 Apr 2013 14:18:22 UTC +00:00")
    Time.stub(:now).and_return(@time_now)
  end

  describe 'created_by_name' do
    it 'returns the name with the format date' do
      instance.created_by = current_user
      instance.created_at = @time_now
      expect(instance.created_by_name).to eql('Bob Baboon (2013-04-10)')
    end
  end

  describe 'updated_by_name' do
    it 'returns the name with the format date' do
      instance.updated_by = current_user
      instance.updated_at = @time_now
      expect(instance.updated_by_name).to eql('Bob Baboon (2013-04-10)')
    end
  end

  describe 'pretty_created_at' do
    it 'returns a formated date' do
      instance.created_at = @time_now
      expect(instance.pretty_created_at).to eql('2013-04-10')
    end
  end

  describe 'pretty_updated_at' do
    it 'returns a formated date' do
      instance.updated_at = @time_now
      expect(instance.pretty_updated_at).to eql('2013-04-10')
    end
  end

end