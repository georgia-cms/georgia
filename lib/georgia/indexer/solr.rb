require 'georgia/indexer/solr/georgia/page'
require 'georgia/indexer/solr/georgia/message'
module Georgia::Indexer::Solr
  def self.extend_model model
    if model == ::Georgia::Page
      model.send(:extend, Georgia::Page)
    elsif model == ::Georgia::Message
      model.send(:extend, Georgia::Message)
    end
  end
end