class Ckeditor::Asset < ActiveRecord::Base

  # to allow media_path in to_jq_upload
  include Georgia::Engine.routes.url_helpers

  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Georgia::Concerns::Taggable

  delegate :url, :current_path, :size, :content_type, to: :data

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
      "delete_url" => media_path(id: id),
      "delete_type" => "DELETE"
    }
  end

  def extension
    @extension ||= data_content_type.gsub(/.*\/(.*)/, '\1')
  end

  searchable do
    text :filename, stored: true
    text :tags do
      tag_list.join(', ')
    end
    string :tags, stored: true, multiple: true do
      tag_list
    end
    string :extension, stored: true do
      extension.try(:downcase)
    end
    time :updated_at
    integer :size, stored: true do
      size / 1024 # gives size in KB
    end
  end

  SIZE_RANGE = {
    '< 25 KB' => 0..25,
    '25 KB to 100 KB' => 25..100,
    '100 KB to 500 KB' => 100..500,
    '500 KB to 1 MB' => 500..1000,
    '> 1 MB' => 1000..999999
  }



end