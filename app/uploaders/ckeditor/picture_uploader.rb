module Ckeditor
  class PictureUploader < CarrierWave::Uploader::Base

    include Georgia::Uploader::Adapter

    def extension_white_list
      Ckeditor.image_file_types
    end

    version :tiny do
      process resize_to_fill: [65, 65]
    end

    version :thumb do
      process resize_to_fill: [160, 120]
    end

    version :content do
      process resize_to_limit: [800, 800]
    end

  end
end