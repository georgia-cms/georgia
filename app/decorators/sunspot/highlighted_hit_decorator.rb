module Sunspot
  class HighlightedHitDecorator < Georgia::ApplicationDecorator

    def method_missing(meth, *args, &block)
      if source.highlights(meth) and source.highlights(meth).present?
        highlight_text_on(meth)
      elsif source.stored(meth) and source.stored(meth).is_a? Array
        source.stored(meth).join(', ')
      elsif source.stored(meth) and source.stored(meth).present?
        source.stored(meth)
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