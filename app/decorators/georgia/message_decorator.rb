module Georgia
  class MessageDecorator < Georgia::ApplicationDecorator

    def phone_or_none
      phone.present? ? phone : h.content_tag(:span, 'no phone', class: 'muted')
    end

    def subject_truncated
      subject.present? ? h.truncate(subject, length: 20) : h.content_tag(:span, 'no subject', class: 'muted')
    end

    def message_truncated
      h.truncate(message, length: 50)
    end

  end
end