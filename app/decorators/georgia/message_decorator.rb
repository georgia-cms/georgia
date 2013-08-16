module Georgia
  class MessageDecorator < Georgia::ApplicationDecorator

    def subject_truncated
      h.truncate(model.subject, :length => 20)
    end

    def message_truncated
      h.truncate(model.message, :length => 50)
    end

  end
end