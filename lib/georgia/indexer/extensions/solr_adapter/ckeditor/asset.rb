require 'active_support/concern'

module Georgia
  module Indexer
    module SolrAdapter
      module CkeditorAssetExtension

        extend ActiveSupport::Concern

        included do

          searchable do
            text :filename, stored: true
            text :tags do
              tag_list.join(', ')
            end
            string :tags, stored: true, multiple: true do
              tag_list
            end
            string :extension, stored: true do
              extension.try(:downcase)
            end
            time :updated_at
            integer :size, stored: true do
              size / 1024 # gives size in KB
            end
          end

          def self.search_index model, params
            model.search(:include => [{contents: :contentable}]) do
              fulltext params[:query] do
                fields(:filename, :tags)
              end
              with(:extension, params[:e]) unless params[:e].blank?
              with(:tags).any_of(params[:tg]) unless params[:tg].blank?
              order_by (params[:o] || :updated_at), (params[:dir] || :desc)
              paginate(page: params[:page], per_page: (params[:per] || 8))
            end
          end

        end

      end
    end
  end
end