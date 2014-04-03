require 'active_support/concern'

module Georgia
  module Indexer
    module SolrAdapter
      module ActsAsTaggableOnTagExtension

        extend ActiveSupport::Concern

        included do

          searchable do
            text :name
            string :id, stored: true
            string :name, stored: true
          end

          def self.search_index query
            @search = search do
              fulltext query do
                fields(:name)
              end
              paginate(page: 1, per_page: 10)
            end
            @search.hits.map{|t| {id: t.stored(:id), text: t.stored(:name)}}
          end

        end

      end
    end
  end
end