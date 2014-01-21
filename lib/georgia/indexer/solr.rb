require 'georgia/indexer/solr/georgia/page'
module Georgia::Indexer::Solr
  def self.extend_model model
    if model == ::Georgia::Page
      model.send(:extend, Georgia::Page)
    end
  end
end