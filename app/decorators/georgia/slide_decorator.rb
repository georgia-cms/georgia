module Georgia
  class SlideDecorator < Georgia::ApplicationDecorator
    delegate :image, to: :content

  end
end