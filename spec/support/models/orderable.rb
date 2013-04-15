shared_examples "a orderable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }

  it { should respond_to :position }

  describe 'scopes' do
    describe '.ordered' do

      it 'returns links ordered by position' do
        described_class.destroy_all
        @fourth = FactoryGirl.create(model_name, position: 4)
        @third = FactoryGirl.create(model_name, position: 3)
        @first = FactoryGirl.create(model_name, position: 1)
        @second = FactoryGirl.create(model_name, position: 2)
        expect(described_class.ordered.to_a).to eq([@first, @second, @third, @fourth])
      end

    end
  end

end