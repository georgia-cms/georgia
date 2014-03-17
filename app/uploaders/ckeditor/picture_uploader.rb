module Ckeditor
  class PictureUploader < CarrierWave::Uploader::Base

    include Ckeditor::Backend::CarrierWave
    require 'carrierwave/processing/mini_magick'
    include CarrierWave::MiniMagick

    storage :fog

    def store_dir
      "assets/#{model.id}"
    end

    def extension_white_list
      Ckeditor.image_file_types
    end

    process :read_dimensions

    version :tiny do
      process resize_to_fill: [65, 65]
    end

    version :thumb do
      process resize_to_fill: [160, 120]
    end

    version :big_thumb do
      process resize_to_fill: [460, 280, 'North']
    end

    version :content do
      process resize_to_limit: [800, 800]
    end

  end
end