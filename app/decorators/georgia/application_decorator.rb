module Georgia
  class ApplicationDecorator < Draper::Decorator

    delegate_all

    def created_at(options={})
      options[:format] ||= :short
      case options[:format]
      when :short then model.created_at.strftime('%F')
      when :long then model.created_at.strftime('%d %B, %Y - %H:%M')
      end
    end

    def updated_at
      model.updated_at.strftime('%F')
    end

    def created_by
      return '' unless model and model.created_by
      "#{model.created_by.name} (#{created_at})"
    end

    def updated_by
      return '' unless model and model.updated_by
      "#{model.updated_by.name} (#{updated_at})"
    end

    def success_tag
      "<span class='label label-success'><i class='icon-white icon-ok-sign'></i> OK</span>".html_safe
    end

    def error_tag
      "<span class='label label-important'><i class='icon-white icon-remove-sign'></i> Fail</span>".html_safe
    end

    def warning_tag
      "<span class='label label-warning'><i class='icon-white icon-warning-sign'></i> Warning</span>".html_safe
    end

    def published_tag
      model.published? ? success_tag : error_tag
    end

    def seo_completion_tag
      if seo_tags.all?(&:present?)
        success_tag
      elsif seo_tags.all?(&:blank?)
        error_tag
      else
        warning_tag
      end
    end

    def content
      @content ||= model.contents.select{|c| c.locale == I18n.locale.to_s}.first || Content.new
    end

    def title    ; h.raw(content.title)    ; end
    def text     ; h.raw(content.text)     ; end
    def excerpt  ; h.raw(content.excerpt)  ; end
    def keywords ; h.raw(content.keywords) ; end

    private

    def seo_tags
      @seo_tags ||= [content.title, content.text, content.excerpt, content.keywords]
    end

  end
end