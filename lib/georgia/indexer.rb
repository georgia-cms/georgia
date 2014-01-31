module Georgia
  module Indexer
    autoload :SolrAdapter, 'georgia/indexer/solr_adapter'
    autoload :TireAdapter, 'georgia/indexer/tire_adapter'

    mattr_accessor :adapter

    def self.adapter
      @@adapter ||= adapter_lookup
    end

    # Delegates search to the adapter
    def self.search model, params
      @@adapter.search model, params
    end

    def self.searching model, extension
      @@adapter.searching model, extension
    end

    private

    def self.adapter_lookup
      (case Georgia.indexer
        when :solr then SolrAdapter.new
        when :tire then TireAdapter.new
        else
          TireAdapter.new
        end)
    end

  end
end