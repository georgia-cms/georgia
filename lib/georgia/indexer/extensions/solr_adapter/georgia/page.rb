require 'active_support/concern'

module Georgia
  module Indexer
    module SolrAdapter
      module GeorgiaPageExtension

        extend ActiveSupport::Concern

        included do

          searchable do
            text :title, stored: true do
              revisions.map{|r| r.contents.map(&:title)}.flatten.uniq.join(', ')
            end
            text :excerpt, stored: true do
              revisions.map{|r| r.contents.map(&:excerpt)}.flatten.uniq.join(', ')
            end
            text :text do
              revisions.map{|r| r.contents.map(&:text)}.flatten.uniq.join(', ')
            end
            text :keywords do
              revisions.map{|r| r.contents.map(&:keyword_list)}.flatten.uniq.join(', ')
            end
            text :template do
              revisions.map(&:template).uniq.join(', ')
            end
            text :tags do
              tag_list.join(', ')
            end
            text :url
            string :class_name do
              self.class.name
            end
            string :title
            string :excerpt
            string :text
            string :url
            string :template
            string :state do
              publish_state
            end
            string :keywords, stored: true, multiple: true do
              revisions.map{|r| r.contents.map(&:keyword_list)}.flatten.uniq
            end
            string :tag_list, stored: true, multiple: true #Facets (multiple)
            string :tags do #Ordering (single list)
              tag_list.join(', ')
            end
            time :updated_at # default for ordering
          end

          def self.search_index model, params
            @search = model.search do
              fulltext params[:query] do
                fields(:title, :excerpt, :text, :keywords, :tags, :url, :template)
              end
              facet :state, :template, :tag_list
              # ensure pages indexed in the wrong bucket don't get displayed
              with(:class_name, model.to_s)
              with(:state, params[:s]) unless params[:s].blank?
              with(:template, params[:t]) unless params[:t].blank?
              with(:tag_list).all_of(params[:tg]) unless params[:tg].blank?
              order_by (params[:o] || :updated_at), (params[:dir] || :desc)
              paginate(page: params[:page], per_page: (params[:per] || 25))
              instance_eval &model.extra_search_params if model.respond_to? :extra_search_params
            end.results
          end

        end

      end
    end
  end
end