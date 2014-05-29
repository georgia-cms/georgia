module Georgia
  module Api
    class TagsController < Georgia::ApplicationController

      respond_to :json

      def search
        search_conditions = Georgia::TagSearch.new(params).definition
        @search = ActsAsTaggableOn::Tag.search(search_conditions).page(params[:page])
        respond_with(@search.records.map(&:name))
      end

    end
  end
end