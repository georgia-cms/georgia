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

          def self.search_index params
            search(page: (params[:page] || 1), per_page: (params[:per] || 10)) do
              if params[:q].present?
                query do
                  boolean do
                    must { string params[:q], default_operator: "AND" }
                  end
                end
              end
            end
          end

        end
      end
    end
  end
end