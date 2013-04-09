module Georgia
  class ApplicationDecorator < Draper::Decorator

    delegate_all

    %w(created_at updated_at published_at).each do |timestamp|
      define_method("pretty_#{timestamp}") { model.send(timestamp).strftime('%F') }
    end

    def created_by_name
      return '' unless model and model.created_by
      "#{model.created_by.decorate.name} (#{pretty_created_at})"
    end

    def updated_by_name
      return '' unless model and model.updated_by
      "#{model.updated_by.decorate.name} (#{pretty_updated_at})"
    end

    def published_by_name
      return '' unless model and model.published_by
      "#{model.published_by.decorate.name} (#{pretty_published_at})"
    end

    def content
      @content ||= model.contents.select{|c| c.locale == I18n.locale.to_s}.first || Content.new
    end

    def title     ; h.raw(content.title)        ; end
    def text      ; h.raw(content.text)         ; end
    def excerpt   ; h.raw(content.excerpt)      ; end
    def keywords  ; h.raw(content.keyword_list) ; end
    def image     ; content.image               ; end

  end
end