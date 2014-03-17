module Ckeditor
  class AttachmentFileUploader < CarrierWave::Uploader::Base
    include Ckeditor::Backend::CarrierWave

    storage :fog

    def store_dir
      "assets/#{model.id}"
    end

    def extension_white_list
      %w(doc docx odt xls ods csv pdf rar zip tar tar.gz ppt pptx) + Ckeditor.image_file_types
    end
  end
end