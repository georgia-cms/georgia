module Georgia
  module Api
    class MediaController < Georgia::ApplicationController

      def pictures
        search_conditions = Georgia::PictureSearch.new(params).definition
        @search = Ckeditor::Picture.search(search_conditions).page(params[:page]).per(params.fetch(:per, 12))
        @pictures = Ckeditor::PictureDecorator.decorate_collection(@search.records)
        render layout: false
      end

    end
  end
end