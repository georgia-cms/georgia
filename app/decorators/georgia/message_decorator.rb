module Georgia
  class MessageDecorator < ApplicationDecorator
    decorates :message, class: Georgia::Message

    def sent_on
      @applied_at ||= created_at
    end

    def subject
      @subject ||= model.subject
    end

    def message    
      @message ||= h.truncate(model.message, :length => 80)
      h.link_to @message, '', :rel => 'popover', 'data-original-title' => subject, 'data-content' => model.message
    end

  end
end