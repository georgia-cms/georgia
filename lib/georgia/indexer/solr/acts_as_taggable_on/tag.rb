module Georgia
  module Indexer
    module Solr
      module ActsAsTaggableOn
        module Tag
          def self.extended(base)
            base.class_eval do
              searchable do
                text :name
              end
            end
          end
        end
      end
    end
  end
end