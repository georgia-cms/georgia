module Georgia
  module UiHelper

    def avatar_url(email, options={})
      gravatar_id = Digest::MD5.hexdigest(email.try(:downcase))
      size = options.fetch(:size, '32')
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm"
    end

    def icon_tag icon_name, options={}
      options[:class] ||= ''
      options[:class] << "fa fa-#{icon_name}"
      content_tag :i, nil, options
    end

    def caret_tag
      content_tag :span, nil, class: 'caret'
    end

    def spinner_tag options={}
      options[:class] = options.fetch(:class, 'spinner')
      content_tag :div, icon_tag('spinner fa-spin fa-4x'), options
    end

    def picture_tag picture, options={}
      return unless picture and picture.url.present?
      format = options.fetch(:format, :tiny)
      link_to picture.url_content, class: 'media-link bg-transparent', rel: 'shadowbox[gallery]' do
        image_tag(picture.url(format), title: picture.data_file_name, class: 'media-image')
      end
    end

    def link_to_back url=:back
      link_to icon_tag('level-up fa-rotate-270'), url, class: 'btn btn-back'
    end

    def link_to_available_locales
      return unless I18n.available_locales.any?
      links = I18n.available_locales.map do |locale|
        content_tag(:li, link_to(t("georgia.#{locale}"), locale: locale ))
      end
      content_tag(:p, class: 'hint') do
        content_tag(:div, class: 'dropdown') do
          link_to("Change language <span class='caret'></span>".html_safe, '#', class: 'btn btn-warning', data: {toggle: 'dropdown'}, role: :button) +
          content_tag(:ul, links.join('').html_safe, class: 'dropdown-menu', role: 'menu')
        end
      end
    end

    def link_to_delete url, options={}
      text = options.delete(:text) { "#{icon_tag('trash-o')} Delete".html_safe }
      link_to text, url, options.reverse_merge(data: {confirm: 'Are you sure?'}, method: :delete, class: 'btn btn-danger')
    end

    def tooltip_tag icon, tooltip, options={}
      content_tag(:span, icon, options.reverse_merge(title: tooltip, class: 'js-tooltip', data: {placement: 'right'}))
    end

    def welcomed?
      session[:welcomed] || !(session[:welcomed] = true)
    end

  end
end