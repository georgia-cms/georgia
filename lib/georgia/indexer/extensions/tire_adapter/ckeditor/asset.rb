require 'active_support/concern'

module Georgia
  module Indexer
    module TireAdapter
      module CkeditorAssetExtension

        extend ActiveSupport::Concern

        included do

          include ::Tire::Model::Search
          include ::Tire::Model::Callbacks

          def to_indexed_json
            indexed_hash = {
              filename: filename,
              tags: tags,
              extension: extension,
              updated_at: updated_at.strftime('%F')
            }
            indexed_hash.to_json
          end

          def self.search_index params
            search(page: (params[:page] || 1), per_page: (params[:per] || 8)) do
              if params[:query].present?
                query do
                  boolean do
                    must { string params[:query], default_operator: "AND" }
                  end
                end
                sort { by (params[:o] || :updated_at), (params[:dir] || :desc) }
              end
            end.results
          end

        end

      end
    end
  end
end