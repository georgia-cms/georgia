module Georgia
  class MessageDecorator < Georgia::ApplicationDecorator

    def description
      h.truncate(model.message, :length => 80)
    end

  end
end