require 'spec_helper'

describe Georgia::Indexer do

  it {should respond_to :adapter }
  it {should respond_to :search }
  it {should respond_to :register_extension }

  let(:adapter) {ENV['TRAVIS'] ? Georgia::Indexer::TireAdapter : Georgia::Indexer::SolrAdapter}

  describe '.adapter' do
    it 'defaults to Tire' do
      expect(Georgia::Indexer.adapter).to be adapter
    end
  end

  describe '.search' do
    it 'delegates to adapter' do
      expect(adapter).to receive(:search)
      Georgia::Indexer.search(Georgia::Page, {})
    end
  end

end