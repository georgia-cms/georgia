module Georgia
  module Api
    class MediaController < Georgia::ApplicationController

      def pictures
        @search = Ckeditor::Picture.search do
          fulltext params[:query] do
            fields(:filename, :tags)
          end
          paginate(page: params[:page], per_page: (params[:per] || 12))
        end
        @pictures = @search.results
        render layout: false
      end

    end
  end
end