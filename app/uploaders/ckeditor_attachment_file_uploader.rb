# encoding: utf-8
class CkeditorAttachmentFileUploader < CarrierWave::Uploader::Base
  include Ckeditor::Backend::CarrierWave

  storage :fog

  def store_dir
    "assets/#{model.id}"
  end

  def extension_white_list
    %w(doc docx odt xls ods csv pdf rar zip tar tar.gz ppt pptx)
  end


end