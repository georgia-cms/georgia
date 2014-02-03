ActsAsTaggableOn::Tag.class_eval do

  include Georgia::Indexer::Adapter
  is_searchable({
    solr: Georgia::Indexer::SolrAdapter::ActsAsTaggableOnTagExtension,
    tire: Georgia::Indexer::TireAdapter::ActsAsTaggableOnTagExtension,
  })

end