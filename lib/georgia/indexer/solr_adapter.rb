require 'sunspot_rails'
require 'georgia/indexer/solr/georgia/page'
require 'georgia/indexer/solr/georgia/message'
require 'georgia/indexer/solr/ckeditor/asset'
require 'georgia/indexer/solr/acts_as_taggable_on/tag'

module Georgia::Indexer
  class SolrAdapter < Adapter

    def initialize
      extend_models
    end

    private

    def extend_models
      ::Georgia::Page.send(:extend, Georgia::Indexer::Solr::Georgia::Page)
      ::Georgia::Message.send(:extend, Georgia::Indexer::Solr::Georgia::Message)
      ::Ckeditor::Asset.send(:extend, Georgia::Indexer::Solr::Ckeditor::Asset)
      ::ActsAsTaggableOn::Tag.send(:extend, Georgia::Indexer::Solr::ActsAsTaggableOn::Tag)
    end
  end
end