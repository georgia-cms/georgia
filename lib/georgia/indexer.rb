module Georgia
  module Indexer
    autoload :Solr, 'georgia/indexer/solr'

    def self.included(base)
      adapter_class.extend_model(base)
    end

    def self.adapter_class
      case Georgia.indexer
      when :solr then Georgia::Indexer::Solr
      else
        Georgia::Indexer::Solr
      end
    end
  end
end