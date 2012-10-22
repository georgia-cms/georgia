module Georgia
  class MessageDecorator < ApplicationDecorator
    decorates :message, class: Georgia::Message

    def message
      h.truncate(model.message, :length => 80)
    end

  end
end