module Georgia
  module Indexer
    module SolrAdapter
      extend Adapter

      require 'sunspot_rails' if defined?(Sunspot)

      class << self

        # Delegate search_index to the model
        # Search method is taken by Sunspot
        def search model, params
          model.search_index(model, params)
        end

      end

    end
  end
end