module Georgia
  class MessageActionsPresenter

    attr_reader :view, :message
    delegate :icon_tag, :content_tag, :link_to, :controller_name, :url_for, :main_app, :can?, :caret_tag, to: :view

    def initialize view, message
      @view = view
      @message = (message.decorated? ? message.object : message)
    end

    def to_s
      html = ActiveSupport::SafeBuffer.new
      html << content_tag(:li, link_to_print)
      if spam?
        html << content_tag(:li, link_to_ham) if can?(:ham, message)
      else
        html << content_tag(:li, link_to_spam) if can?(:spam, message)
      end
      html << content_tag(:li, link_to_trash) if can?(:destroy, message)
      html
    end

    private

    def link_to_print
      link_to "#{icon_tag('print')} Print".html_safe, "javascript:window.print()", target: '_blank'
    end

    def link_to_reply
      link_to "#{icon_tag('reply')} Reply".html_safe, "mailto:#{@message.email}", target: '_blank'
    end

    def link_to_ham
      link_to "#{icon_tag('thumbs-up')} Mark as ham".html_safe, [:ham, @message]
    end

    def link_to_spam
      link_to "#{icon_tag('thumbs-down')} Mark as spam".html_safe, [:spam, @message]
    end

    def link_to_trash
      link_to "#{icon_tag('trash-o')} Trash".html_safe, @message, method: :delete, data: {confirm: 'Are you sure?'}
    end

    def spam?
      @message.spam?
    end

  end
end