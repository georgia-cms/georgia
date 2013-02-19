module Ckeditor
  class AssetDecorator < Georgia::ApplicationDecorator


    def file_name
      source.data.file.filename
    end

    def list_all_tags
      h.raw source.tags.map{ |t| h.link_to t.name, h.tag_path(t) }.join(', ')
    end

  end
end