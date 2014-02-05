module Georgia
  module Indexer
    module SolrAdapter

      require 'sunspot_rails' if defined?(Sunspot)

      # Delegate search_index to the model
      # Search method is taken by Sunspot
      def self.search model, params
        model.search_index model, params
      end

    end
  end
end