require 'active_support/concern'

module Georgia
  module Indexer
    module TireAdapter
      module ActsAsTaggableOnTagExtension
        extend ActiveSupport::Concern

        included do

          include ::Tire::Model::Search
          include ::Tire::Model::Callbacks

          def to_indexed_json
            {name: name}.to_json
          end

          def self.search_index query_string
            @search = search(page: 1, per_page: 10) do
              if query_string.present?
                query do
                  boolean do
                    must { string query_string, default_operator: "AND" }
                  end
                end
              end
            end
            @search.results.map{|t| {id: t.id, text: t.name}}
          end

        end
      end
    end
  end
end