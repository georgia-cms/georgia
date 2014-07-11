module Georgia
  module UiHelper

    def avatar_url(email, options={})
      gravatar_id = Digest::MD5.hexdigest(email.try(:downcase))
      size = options.fetch(:size, '32')
      "//gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=mm"
    end

    def caret_tag
      content_tag :span, nil, class: 'caret'
    end

    def link_to_back url=:back
      link_to icon_tag('level-up fa-rotate-270'), url, class: 'btn btn-back'
    end

    def link_to_delete url, options={}
      text = options.delete(:text) { "#{icon_tag('trash-o')} Delete".html_safe }
      link_to text, url, options.reverse_merge(data: {confirm: 'Are you sure?'}, method: :delete, class: 'btn btn-danger')
    end

    # Link to close modal box
    def link_to_close
      content_tag :button, icon_tag('times'), class: 'close', data: {dismiss: 'modal'}, aria: {hidden: true}, type: 'button'
    end

    def tooltip_tag icon, tooltip, options={}
      content_tag(:span, icon, options.reverse_merge(title: tooltip, class: 'js-tooltip', data: {placement: 'right'}))
    end

    def welcomed?
      session[:welcomed] || !(session[:welcomed] = true)
    end

    def button_to_settings
      link_to "#{icon_tag('cogs')} Settings".html_safe, [:settings, @page], class: 'btn btn-default'
    end

    def button_to_edit
      link_to "#{icon_tag('pencil')} Edit".html_safe, [:edit, @page], class: 'btn btn-info'
    end

    def page_actions_tag page, revision=nil, options={}
      revision ||= page.current_revision
      Georgia::PageActionsPresenter.new(self, page, revision, options)
    end

    def page_url_minus_slug
      @page_full_url ||= (Georgia.url + @page.url).gsub(@page.slug, '')
    end

    def warning_message page, revision, options={}
      Georgia::WarningMessage.new(self, page, revision, options)
    end

    def picture_tag picture, options={}
      return unless picture and picture.url.present?
      format = options.fetch(:format, :tiny)
      link_to picture.url_content, class: 'media-link bg-transparent', rel: 'shadowbox[gallery]' do
        image_tag(picture.url(format), title: picture.data_file_name, class: 'media-image')
      end
    end

    def link_to_available_locales
      return unless I18n.available_locales.length > 1
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

  end
end