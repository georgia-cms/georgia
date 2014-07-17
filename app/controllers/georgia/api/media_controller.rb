module Georgia
  module Api
    class MediaController < Georgia::ApplicationController

      def pictures
        authorize Ckeditor::Asset
        search_conditions = Georgia::MediaSearch.new(params.merge(only: [:pictures])).definition
        @search = Ckeditor::Asset.search(search_conditions).page(params[:page]).per(params.fetch(:per, 12))
        @pictures = Ckeditor::PictureDecorator.decorate_collection(@search.records)
        render layout: false
      end

    end
  end
end