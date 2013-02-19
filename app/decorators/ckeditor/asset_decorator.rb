module Ckeditor
  class AssetDecorator < Georgia::ApplicationDecorator

    def list_all_tags
      h.raw model.tags.map{ |t| h.link_to t.name, h.tag_path(t) }.join(', ')
    end

  end
end