class PhotoDecorator < ApplicationDecorator
  decorates :photo

  def image_tag
    h.image_tag image_url, alt: ''
  end
  
end