module Georgia
  module Indexer
    module Solr
      module Georgia
        module Page
          def self.extended(base)
            base.class_eval do
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
            end
          end
        end
      end
    end
  end
end