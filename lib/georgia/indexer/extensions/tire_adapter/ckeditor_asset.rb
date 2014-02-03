require 'active_support/concern'

module Georgia
  module Indexer
    class TireAdapter
      module CkeditorAssetExtension

        extend ActiveSupport::Concern

        included do

          include ::Tire::Model::Search
          include ::Tire::Model::Callbacks

          mapping do
            indexes :id,           :index    => :not_analyzed
            indexes :filename
            indexes :tags
            indexes :extension
            indexes :updated_at, :type => 'date'
          end

          def self.search model, params
            model.tire.search(page: (params[:page] || 1), per_page: (params[:per] || 8)) do
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