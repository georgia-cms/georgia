class Ckeditor::Picture < Ckeditor::Asset

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  index_name 'ckeditor-assets'
  document_type 'asset'
  include Ckeditor::AssetSearch

  mount_uploader :data, Ckeditor::PictureUploader, mount_on: :data_file_name

  has_many :contents, foreign_key: :image_id, class_name: Georgia::Content

  def featured?
    @featured ||= !contents_count.zero?
  end

  def pages
    @pages ||= contents.map(&:contentable).map(&:page).compact.uniq
  end

  def filename
    @filename ||=
      if defined?(Cloudinary)
        data_file_name.dup.gsub(/v\d{10}\/(.*)/, '\1') || data_file_name
      else
        data_file_name
      end
  end

  def image?
    true
  end

end