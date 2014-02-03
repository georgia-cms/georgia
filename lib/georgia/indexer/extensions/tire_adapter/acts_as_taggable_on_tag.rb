require 'active_support/concern'

module Georgia
  module Indexer
    class TireAdapter
      module ActsAsTaggableOnTagExtension

        extend ActiveSupport::Concern

        included do

          include ::Tire::Model::Search
          include ::Tire::Model::Callbacks

          def to_indexed_json
            {name: name}.to_json
          end

        end

      end
    end
  end
end