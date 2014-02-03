require 'sunspot_rails' if defined?(Sunspot)
Dir[File.join(File.dirname(__FILE__), 'extensions', 'solr_adapter', '*.rb')].each {|file| require file }

module Georgia
  module Indexer
    class SolrAdapter

      # Delegate search_index to the model
      # Search method is taken by Sunspot
      def search model, params
        model.search_index model, params
      end

    end
  end
end