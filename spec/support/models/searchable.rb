shared_examples "a searchable model" do

  describe '.search' do

    it "should respond to .search" do
      described_class.should respond_to :search
    end

    it 'allows for full text search by query' do
      pending 'Change test db to postgresql'
    end

  end

end