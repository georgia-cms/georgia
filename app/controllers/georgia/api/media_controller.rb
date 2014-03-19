module Georgia
  module Api
    class MediaController < Georgia::ApplicationController

      def pictures
        @search = Georgia::Indexer.search(Ckeditor::Picture, params.merge(per: 12))
        @pictures = Ckeditor::PictureDecorator.decorate_collection(@search.results)
        render layout: false
      end

    end
  end
end