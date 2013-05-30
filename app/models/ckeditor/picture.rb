class Ckeditor::Picture < Ckeditor::Asset

  # to allow media_path in to_jq_upload
  include Georgia::Engine.routes.url_helpers

  mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name

end