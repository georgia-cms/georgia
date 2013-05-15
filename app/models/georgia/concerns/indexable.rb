require 'active_support/concern'

module Georgia
  module Concerns
    module Indexable
      extend ActiveSupport::Concern

      included do

        searchable do
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
          text :status_name
          string :type
          string :title
          string :excerpt
          string :text
          string :url
          string :template
          string :status_name
          string :keywords, stored: true, multiple: true do
            contents.map(&:keyword_list).flatten
          end
          string :tag_list, stored: true, multiple: true #Facets (multiple)
          string :tags do #Ordering (single list)
            tag_list.join(', ')
          end
        end

      end

    end
  end
end