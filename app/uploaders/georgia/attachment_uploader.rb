# encoding: utf-8
module Georgia
  class AttachmentUploader < CarrierWave::Uploader::Base

    storage :fog

    def store_dir
      "/uploads/ckeditor/attachments/#{model.id}"
    end

    def extension_white_list
      Ckeditor.attachment_file_types
    end

  end
end