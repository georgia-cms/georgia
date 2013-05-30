module Sunspot
  class HighlightedHitDecorator < ::ApplicationDecorator

    def method_missing(meth, *args, &block)
      if source.highlights(meth) and source.highlights(meth).any?
        highlight_text_on(meth)
      elsif source.stored(meth) and source.stored(meth).any?
        source.stored(meth).first
      elsif source.result
        source.result.send(meth)
      else
        super
      end
    end

    def source_class_name
      source.class_name.parameterize
    end

    private

    def highlight_text_on key, options={}
      source.highlights(key).map{|hl| hl.format{|word| h.content_tag(:span, word, class: 'highlight') } }.join().html_safe
    end

  end
end