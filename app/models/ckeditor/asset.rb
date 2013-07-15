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

  # FIXME: Shouldn't we store extension and filename in the db?
  def extension
    self.try(:data).try(:file).try(:extension)
  end
  def filename
    self.try(:data).try(:file).try(:filename)
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
  end

end