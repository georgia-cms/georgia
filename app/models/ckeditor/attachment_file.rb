class Ckeditor::AttachmentFile < Ckeditor::Asset

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  index_name 'ckeditor-assets'
  document_type 'asset'
  include Ckeditor::AssetSearch

  mount_uploader :data, Ckeditor::AttachmentFileUploader, :mount_on => :data_file_name

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
