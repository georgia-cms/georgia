module Georgia
  module Indexer
    module TireAdapter

      require 'tire' if defined?(Tire)

      class << self

        # Delegate to .search_index on the model
        def search model, params
          model.search_index(params)
        end

      end

    end
  end
end