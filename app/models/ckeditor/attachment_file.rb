class Ckeditor::AttachmentFile < Ckeditor::Asset

  index_name 'ckeditor-assets'
  document_type 'asset'

  mount_uploader :data, Ckeditor::AttachmentFileUploader, :mount_on => :data_file_name

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
