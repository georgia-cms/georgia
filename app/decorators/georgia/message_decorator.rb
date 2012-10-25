module Georgia
  class MessageDecorator < ApplicationDecorator
    decorates :message, class: Georgia::Message

    def description
      h.truncate(model.message, :length => 80)
    end

    def message
      model.message
    end

  end
end