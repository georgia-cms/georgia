module Georgia
  module Indexer
    module Solr
      module Ckeditor
        module Asset
          def self.extended(base)
            base.class_eval do
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
            end
          end
        end
      end
    end
  end
end