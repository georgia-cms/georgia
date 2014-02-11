# TODO: Move to Georgia::Indexer
module Georgia
  module Api
    class TagsController < Georgia::ApplicationController

      respond_to :json

      def search
        @tags = Georgia::Indexer.search(ActsAsTaggableOn::Tag, params)

        # Format for select2
        @tags = @tags.map{|t| {id: t.id, text: t.name}}

        respond_with(results: @tags)
      end

    end
  end
end