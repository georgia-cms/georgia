module Georgia
  class SlidePortlet < Portlet

    delegate :choose_image_tag, :picture_tag, :text_field_tag, :text_area_tag, :dom_id, to: :view_context

    def initialize view_context, slide, args={}
      @content = args.fetch(:content, slide.content)
      super
    end

    def to_s
      output = ActiveSupport::SafeBuffer.new
      output << destroy_input_tag
      output << id_input_tag if persisted?
      output << actions_tag
      output << slide_tag
      portlet_tag(output)
    end

    private

    def title
      @title ||= @portlet.title
    end

    def slide_tag
      content_tag(:span, class: 'slide') do
        media_library_trigger_tag + slide_content_tag
      end
    end

    def media_library_trigger_tag
      content_tag :div, choose_image_tag(@portlet.content, input: image_input_tag, target: image_dom_id), class: 'slide-image'
    end

    def image_input_tag
      hidden_field_tag("revision[slides_attributes][#{id}][contents_attributes][#{content_id}][image_id]", @content.image_id)
    end

    def slide_content_tag
      content_tag(:div, title_input_tag + text_input_tag + locale_input_tag, class: 'slide-text')
    end

    def id_input_tag
      hidden_field_tag("revision[slides_attributes][#{id}][id]", id)
    end

    def title_input_tag
      text_field_tag("revision[slides_attributes][#{id}][contents_attributes][#{content_id}][title]", @content.title, class: 'string', placeholder: 'Title')
    end

    def text_input_tag
      text_area_tag("revision[slides_attributes][#{id}][contents_attributes][#{content_id}][text]", @content.text, rows: 6, placeholder: 'Content')
    end

    def locale_input_tag
      hidden_field_tag("revision[slides_attributes][#{id}][contents_attributes][#{content_id}][locale]", @content.locale)
    end

    def destroy_input_tag
      hidden_field_tag("revision[slides_attributes][#{id}][_destroy]", 0, class: 'js-destroy')
    end

    def actions_tag
      content_tag(:div, link_to(icon_tag('times'), '#', class: 'btn-delete js-remove-slide'), class: 'actions')
    end

    def content_id
      @content.persisted? ? @content.id : 0
    end

    def image_dom_id
      @portlet.persisted? ? dom_id(@portlet, :image) : "image_slide_#{Time.now.to_i}"
    end

  end
end