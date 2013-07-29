shared_examples "a orderable model" do

  let(:model_name) { described_class.name.underscore.gsub(/\//, '_').to_sym }

  it { should respond_to :position }

  describe 'scopes' do
    describe '.ordered' do

      it 'returns links ordered by position' do
        DatabaseCleaner.clean
        @fourth = create(model_name, position: 4)
        @third = create(model_name, position: 3)
        @first = create(model_name, position: 1)
        @second = create(model_name, position: 2)
        described_class.ordered.to_a.should have(4).items
        expect(described_class.ordered.to_a).to eql([@first, @second, @third, @fourth])
      end

    end
  end

end