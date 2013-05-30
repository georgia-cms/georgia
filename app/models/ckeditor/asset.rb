class Ckeditor::Asset < ActiveRecord::Base

  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Georgia::Concerns::Taggable

  delegate :url, :current_path, :size, :content_type, :filename, to: :data

  mount_uploader :data, CkeditorAttachmentFileUploader, mount_on: :data_file_name

  validates :data, presence: true
  attr_accessible :data

  paginates_per 15

  scope :latest, order('created_at DESC')

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
