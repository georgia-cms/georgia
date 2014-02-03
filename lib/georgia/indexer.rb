require 'active_support/concern'

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

    def self.searching model, extension
      adapter.searching model, extension
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

    module Adapter
      extend ActiveSupport::Concern

      included do
        def self.is_searchable extensions={}
          raise "No extension for the #{Georgia.indexer} indexer" unless extensions[Georgia.indexer].present?
          self.send(:include, extensions[Georgia.indexer])
        end
      end
    end

  end
end