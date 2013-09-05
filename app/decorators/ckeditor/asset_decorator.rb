module Ckeditor
  class AssetDecorator < Georgia::ApplicationDecorator

    def list_all_tags
      h.raw model.tags.map{ |t| h.link_to t.name, h.tag_path(t) }.join(', ')
    end

    def filename_truncated
      h.truncate(data_file_name, length: 30)
    end

  end
end