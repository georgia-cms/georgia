module Georgia
  class UiAssociationDecorator < ApplicationDecorator

    delegate :text, :excerpt, :featured_image, :url, :title, to: :widget

    def title_tag
      if url
        h.link_to title, h.url_for(url)
      else
        title
      end
    end

  end
end