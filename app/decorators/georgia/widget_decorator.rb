module Georgia
  class WidgetDecorator < Georgia::ApplicationDecorator
    delegate :image, to: :content
  end
end