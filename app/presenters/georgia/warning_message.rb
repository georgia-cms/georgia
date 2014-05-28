module Georgia
  class WarningMessage < Presenter

    attr_reader :page, :revision, :options

    def initialize view_context, page, revision, options={}
      @page = page
      @revision = revision
      @options = options
      super
    end

    def to_s
      return nil unless message
      html = ActiveSupport::SafeBuffer.new
      html << warning_icon_tag
      html << message
      content_tag(:div, content_tag(:p, html), class: 'warning-message')
    end

    private

    def warning_icon_tag
      content_tag(:span, icon_tag('warning'), class: 'label label-warning')
    end

    def message
      case revision.state
      when 'review' then review_message
      when 'revision' then revision_message
      else nil
      end
    end

    def review_message
      review_message = "This revision is awaiting review from an Editor."
      # if can? :approve, revision
        review_message << " #{link_to 'Approve Changes', [:approve, page, revision], class: 'btn btn-primary btn-xs'}"
      # elsif can? :review, revision
      #   review_message << " #{link_to 'Request Review', [:review, page, revision], class: 'btn btn-primary btn-xs'}"
      # end
      review_message.html_safe
    end

    def revision_message
      return nil if current_revision?
      revision_message ||= "You are looking at a past revision. Updating this content will not change anything on your website. Click #{link_to 'here', [:edit, @page, @page.current_revision], class: 'text-primary'} to edit the current revision.".html_safe
    end

    def current_revision?
      @is_current_revision ||= page.current_revision == revision
    end

  end
end