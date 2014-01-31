require 'sunspot_rails'
Dir[File.join(File.dirname(__FILE__), 'extensions', 'solr', '*.rb')].each {|file| require file }

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