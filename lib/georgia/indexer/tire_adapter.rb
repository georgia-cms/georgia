require 'georgia/indexer/tire/georgia/page'
require 'georgia/indexer/tire/georgia/message'
require 'georgia/indexer/tire/ckeditor/asset'

module Georgia::Indexer
  class TireAdapter < Adapter

    def initialize
      extend_models
    end

    private

    def extend_models
      ::Georgia::Page.send(:extend, Georgia::Indexer::Tire::Georgia::Page)
      ::Georgia::Message.send(:extend, Georgia::Indexer::Tire::Georgia::Message)
      ::Ckeditor::Asset.send(:extend, Georgia::Indexer::Tire::Ckeditor::Asset)
    end
  end
end