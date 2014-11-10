require 'active_support/concern'

module Georgia
  module Concerns
    module Searchable
      extend ActiveSupport::Concern

      included do

        include Elasticsearch::Model
        include Elasticsearch::Model::Callbacks

        def as_indexed_json options={}
          self.as_json(
            only: [:id, :updated_at, :slug, :type, :template],
            methods: [:title, :text, :excerpt, :keyword_list, :tag_list]
            )
        end

      end

      module ClassMethods

        def search_conditions params
          Georgia::PageSearch.new(params).definition
        end

      end

    end
  end
end
