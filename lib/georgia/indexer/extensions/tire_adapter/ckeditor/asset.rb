require 'active_support/concern'

module Georgia
  module Indexer
    module TireAdapter
      module CkeditorAssetExtension

        extend ActiveSupport::Concern

        included do

          include ::Tire::Model::Search
          include ::Tire::Model::Callbacks

          after_rollback do
            self.index.remove(self)
          end

          def to_indexed_json
            indexed_hash = {
              widt: width,
              height: height,
              data_file_name: data_file_name,
              data_file_size: data_file_size,
              data_content_type: data_content_type,
              tags: tags,
              extension: extension,
              thumb_url: url(:thumb),
              tiny_url: url(:tiny),
              content_url: url(:content),
              updated_at: updated_at.strftime('%F')
            }
            indexed_hash.to_json
          end

          def self.search_index params
            page     = params.fetch(:page, 1)
            per_page = params.fetch(:per, 8)

            Tire.search(['ckeditor_assets', 'ckeditor_pictures'],{load: true, page: page, per_page: per_page}) do
              if params[:query].present?
                query do
                  boolean do
                    must { string params[:query], default_operator: "AND" }
                  end
                end
                sort { by (params[:o] || :updated_at), (params[:dir] || :desc) } if params[:query].blank?
              end
            end
          end

        end

      end
    end
  end
end