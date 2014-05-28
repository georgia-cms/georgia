module Georgia
  module Api
    class TagsController < Georgia::ApplicationController

      respond_to :json

      def search
        @tags = ActsAsTaggableOn::Tag.search_index(params[:q])
        respond_with(results: @tags)
      end

    end
  end
end