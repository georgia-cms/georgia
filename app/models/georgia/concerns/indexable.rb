require 'active_support/concern'

module Georgia
  module Concerns
    module Indexable
      extend ActiveSupport::Concern

      included do

        class << self

          # Default fields to be include in searchable block
          # Children of Georgia::Page can use this to extend their own searchable block
          def indexable_fields
            Proc.new {
              text :title, stored: true do
                contents.map(&:title).join(', ')
              end
              text :excerpt, stored: true do
                contents.map(&:excerpt).join(', ')
              end
              text :text do
                contents.map(&:text).join(', ')
              end
              text :keywords do
                contents.map(&:keyword_list).flatten.join(', ')
              end
              text :tags do
                tag_list.join(', ')
              end
              text :url
              text :template
              text :state
              string :type
              string :title
              string :excerpt
              string :text
              string :url
              string :template
              string :state
              string :keywords, stored: true, multiple: true do
                contents.map(&:keyword_list).flatten
              end
              string :tag_list, stored: true, multiple: true #Facets (multiple)
              string :tags do #Ordering (single list)
                tag_list.join(', ')
              end
            }
          end

        end

        searchable do
          instance_eval &Georgia::Page.indexable_fields
        end

      end

    end
  end
end