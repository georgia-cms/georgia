class Ckeditor::Picture < Ckeditor::Asset

  # to allow media_path in to_jq_upload
  include Georgia::Engine.routes.url_helpers

  mount_uploader :data, CkeditorPictureUploader, mount_on: :data_file_name

  def to_jq_upload
    {
      "name" => read_attribute(:data),
      "size" => data.size,
      "url" => data.url,
      "thumbnail_url" => data.thumb.url,
      "delete_url" => media_path(:id => id),
      "delete_type" => "DELETE"
    }
  end
end
