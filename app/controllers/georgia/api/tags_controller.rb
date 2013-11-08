module Georgia
  module Api
    class TagsController < Georgia::ApplicationController

      respond_to :json

      def search
        @search = ActsAsTaggableOn::Tag.search do
          fulltext params[:q] do
            fields(:name)
          end
          paginate(page: 1, per_page: 10)
        end
        # Format for select2
        @tags = @search.results.map{|t| {id: t.id, text: t.name}}

        respond_with(results: @tags)
      end

    end
  end
end