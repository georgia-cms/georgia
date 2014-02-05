module Georgia
  module Api
    class MediaController < Georgia::ApplicationController

      def pictures
        @pictures = Georgia::Indexer.search(Ckeditor::Picture, params.merge(per: 12))
        @pictures = Ckeditor::PictureDecorator.decorate_collection(@pictures)
        render layout: false
      end

    end
  end
end