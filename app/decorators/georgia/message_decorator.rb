module Georgia
  class MessageDecorator < Georgia::ApplicationDecorator

    def phone_or_none
      phone.present? ? phone : h.content_tag(:span, 'no phone', class: 'muted')
    end

    def subject_truncated
      h.truncate(h.strip_tags(subject), length: 60, separator: ' ').html_safe if subject.present?
    end

    def message_truncated
      h.truncate(h.strip_tags(message), length: 200, separator: ' ').html_safe if message.present?
    end

    def name_or_anonymous
      name || 'Anonymous'
    end

  end
end