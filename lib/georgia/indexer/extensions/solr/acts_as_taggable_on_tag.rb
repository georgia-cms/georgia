require 'active_support/concern'

module Georgia
  module Indexer
    module ActsAsTaggableOnTagExtension

      extend ActiveSupport::Concern

      included do

        searchable do
          text :name
        end

      end

    end
  end
end