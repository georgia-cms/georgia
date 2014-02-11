require 'active_support/concern'

module Georgia
  module Indexer
    module SolrAdapter
      module ActsAsTaggableOnTagExtension

        extend ActiveSupport::Concern

        included do

          searchable do
            text :name
          end

          def self.search_index model, params
            ActsAsTaggableOn::Tag.search do
              fulltext params[:q] do
                fields(:name)
              end
              paginate(page: 1, per_page: 10)
            end.results
          end

        end

      end
    end
  end
end