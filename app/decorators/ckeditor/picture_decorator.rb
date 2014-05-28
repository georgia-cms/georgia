module Ckeditor
  class PictureDecorator < Ckeditor::AssetDecorator

    def filesize
      h.number_to_human_size(size)
    end

  end
end