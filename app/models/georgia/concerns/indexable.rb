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
                revisions.map{|r| r.contents.map(&:keyword_list)}.flatten.uniq
              end
              string :tag_list, stored: true, multiple: true #Facets (multiple)
              string :tags do #Ordering (single list)
                tag_list.join(', ')
              end
            }
          end

        end

        searchable do
          instance_eval &self.indexable_fields
        end

      end

    end
  end
end