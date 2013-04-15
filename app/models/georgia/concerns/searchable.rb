require 'active_support/concern'

module Georgia
  module Concerns
    module Searchable
      extend ActiveSupport::Concern

      included do
        include PgSearch
        pg_search_scope :text_search, using: {tsearch: {dictionary: 'english', prefix: true, any_word: true}},
        against: [:slug, :template],
        associated_against: { contents: [:title, :text, :excerpt, :keywords] }
      end

      module ClassMethods

        def search query
          query.present? ? text_search(query) : scoped
        end

      end
    end
  end
end