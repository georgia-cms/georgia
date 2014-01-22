require 'georgia/indexer/adapter'

module Georgia
  module Indexer
    autoload :Solr, 'georgia/indexer/solr'
    autoload :Tire, 'georgia/indexer/tire'

    def self.included(base)
      adapter.extend_model(base)
    end

    def self.adapter
      @adapter ||= Georgia::Indexer::Adapter.new(Georgia.indexer)
    end

  end
end