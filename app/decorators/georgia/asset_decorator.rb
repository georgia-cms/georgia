module Georgia
  class AssetDecorator < Georgia::ApplicationDecorator

    def list_all_tags
      h.raw tag_list.map{ |t| h.link_to t, h.tag_path(t) }.join(', ')
    end

  end
end