require 'georgia/indexer/adapter'

module Georgia
  module Indexer
    autoload :SolrAdapter, 'georgia/indexer/solr_adapter'
    autoload :TireAdapter, 'georgia/indexer/tire_adapter'

    mattr_accessor :adapter

    def self.included(base)
      @@adapter ||= adapter_lookup
    end

    private

    def self.adapter_lookup
      (case Georgia.indexer
        when :solr then Georgia::Indexer::SolrAdapter.new
        when :tire then Georgia::Indexer::TireAdapter.new
        else
          Georgia::Indexer::TireAdapter.new
        end)
    end

  end
end