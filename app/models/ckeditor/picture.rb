class Ckeditor::Picture < Ckeditor::Asset

  mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name

end