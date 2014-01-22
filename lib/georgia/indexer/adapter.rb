module Georgia
  module Indexer
    class Adapter

      def initialize adapter
        @adapter = (case adapter
          when :solr then Georgia::Indexer::Solr
          when :tire then Georgia::Indexer::Tire
          else
            Georgia::Indexer::Tire
          end)
      end

      # Delegate search to the model
      def search model, params
        model.search model, params
      end

      def extend_model model
        @adapter.extend_model model
      end

    end
  end
end