# encoding: utf-8
class CkeditorPictureUploader < CarrierWave::Uploader::Base

  include Ckeditor::Backend::CarrierWave
  require 'carrierwave/processing/mini_magick'
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    'system/ckeditor_assets/pictures/'
  end

  def extension_white_list
    Ckeditor.image_file_types
  end

  def filename
    return unless original_filename
    file_extension = File.extname(original_filename)
    sanitized_name = original_filename.to_s.gsub(file_extension, '').gsub(/[^a-zA-Z0-9_-]/, '').downcase

    # "#{sanitized_name}_#{current_date}#{file_extension}"
    "#{sanitized_name}_#{secure_token(10)}#{file_extension}"
  end


  process :read_dimensions

  version :thumb do
    process resize_to_fill: [160, 120]
  end

  version :big_thumb do
    # process resize_to_fill: [460, 280, 'North'] => North is the gravity type [Center, North]
    process resize_to_fill: [460, 280, 'North']
  end

  version :big_thumb_bw do
    process resize_to_fill: [460, 280]
    process colorspace: 'Gray'
  end

  version :content do
    process resize_to_limit: [800, 800]
  end

  def colorspace(tone)
    manipulate! do |img|
      img.colorspace(tone)
      img = yield(img) if block_given?
      img
    end
  end

  protected

  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end

  def current_date
    "#{Time.now.year}#{Time.now.month.to_s.rjust(2,'0')}#{Time.now.day.to_s.rjust(2,'0')}_#{Time.now.hour.to_s.rjust(2,'0')}#{Time.now.min.to_s.rjust(2,'0')}#{Time.now.sec.to_s.rjust(2,'0')}"
  end

end
