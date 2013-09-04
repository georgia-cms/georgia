class Ckeditor::Picture < Ckeditor::Asset

  mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name

  has_many :contents, foreign_key: :image_id, class_name: Georgia::Content

  def featured?
    @featured ||= !contents_count.zero?
  end

end