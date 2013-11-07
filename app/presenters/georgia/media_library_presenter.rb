module Georgia
  class MediaLibraryPresenter

    attr_accessor :view_context

    delegate :content_tag, :link_to, :picture_tag, :hidden_field_tag, :icon_tag, to: :view_context

    def initialize view_context, imageable, args={}
      @view_context = view_context
      @imageable = imageable
      @target = args.fetch(:target, 'media_library_image')
      @input = args.fetch(:input, image_input_tag)
    end

    def to_s
      content_tag(:div, class: 'media-library-image', id: @target) do
        media_featured_tag + choose_image_button_tag + @input
      end
    end

    def choose_image_button_tag
      link_to("#{icon_tag('picture-o')} Choose Image".html_safe, '#', class: 'btn btn-primary js-media-library', data: {media: "##{@target}", toggle: 'modal', target: '#media_library'})
    end

    def media_featured_tag
      content_tag :div, class: 'media-featured js-media-image' do
        picture_tag(image, format: :thumb)
      end
    end

    def image_input_tag
      hidden_field_tag(:image, image_id)
    end

    def image
      @imageable.image
    end

    def image_id
      @imageable.image_id
    end

  end
end