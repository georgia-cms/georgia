module Georgia
  module Indexer
    module Tire
      module Georgia
        module Message
          def self.extended(base)
            base.class_eval do

              include ::Tire::Model::Search
              include ::Tire::Model::Callbacks

              mapping do
                indexes :id,           :index    => :not_analyzed
                indexes :name
                indexes :email
                indexes :message
                indexes :subject
                indexes :phone
                indexes :spam
                indexes :created_at, :type => 'date'
              end

              def self.search_index model, params
                model.search(params[:query], page: (params[:page] || 1))
              end
            end
          end
        end
      end
    end
  end
end