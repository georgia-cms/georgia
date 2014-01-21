module Georgia
  module Indexer
    module Solr
      module Georgia
        module Message
          def self.extended(base)
            base.class_eval do
              searchable do
                text :name
                text :email
                text :message
                text :subject
                text :phone
                string :spam do
                  status
                end
                # For sorting:
                string :name
                string :email
                string :phone
                string :subject
                string :message
                time :created_at
              end
            end
          end
        end
      end
    end
  end
end