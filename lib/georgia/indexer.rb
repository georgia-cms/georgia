require 'active_support/concern'
require 'georgia/indexer/adapter'

module Georgia
  module Indexer
    autoload :SolrAdapter, 'georgia/indexer/solr_adapter'
    autoload :TireAdapter, 'georgia/indexer/tire_adapter'

    def self.adapter
      @@adapter ||= adapter_lookup
    end

    # Delegates search to the adapter
    def self.search model, params
      adapter.search model, params
    end

    def self.register_extension indexer, klass
      return unless indexer == Georgia.indexer
      Adapter.load_extension(klass)
    end

    private

    def self.adapter_lookup
      @adapter_lookup ||= (case Georgia.indexer
        when :solr then SolrAdapter
        when :tire then TireAdapter
        end)
    end

  end
end