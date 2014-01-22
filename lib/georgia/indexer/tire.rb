require 'georgia/indexer/tire/georgia/page'
require 'georgia/indexer/tire/georgia/message'

module Georgia
  module Indexer
    module Tire

      def self.extend_model model
        if model == ::Georgia::Page
          model.send(:extend, Georgia::Page)
        elsif model == ::Georgia::Message
          model.send(:extend, Georgia::Message)
        end
      end

    end
  end
end