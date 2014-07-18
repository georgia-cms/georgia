require 'active_support/concern'
module Ckeditor
  module AssetSearch
    extend ActiveSupport::Concern

    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks
      index_name 'ckeditor-assets'
      document_type 'asset'

      settings index: {name: 'ckeditor-assets'}, analysis: {
        analyzer: {
          'index_ngram_analyzer'  => {type: 'custom', tokenizer: 'standard', filter: ['standard', 'lowercase', 'my_ngram_filter']},
          'search_analyzer'       => {type: 'custom', tokenizer: 'standard', filter: ['standard', 'lowercase']}
        },
        filter: {
          'my_ngram_filter' => {type: 'nGram', min_gram: 2, max_gram: 10}
        }
      } do
        mapping index_analyzer: 'index_ngram_analyzer', search_analyzer: 'search_analyzer'
      end

      def as_indexed_json options={}
        self.as_json(
          only: [:id, :data_file_name, :updated_at, :type],
          methods: [:tag_list]
        )
      end

      after_touch :reindex
      def reindex
        self.__elasticsearch__.index_document
      end
    end
  end
end