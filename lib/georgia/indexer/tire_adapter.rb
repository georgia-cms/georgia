require 'tire'
Dir[File.join(File.dirname(__FILE__), 'extensions', 'tire', '*.rb')].each {|file| require file }

module Georgia
  module Indexer
    class TireAdapter

      # Delegate search to the model
      def search model, params
        model.search model, params
      end

    end
  end
end