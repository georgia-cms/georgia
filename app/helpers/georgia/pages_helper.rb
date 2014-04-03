module Georgia
  module PagesHelper

    def page_actions_tag page, revision=nil, options={}
      revision ||= page.current_revision
      Georgia::PageActionsPresenter.new(self, page, revision, options)
    end

    def button_to_settings
      link_to "#{icon_tag('cogs')} Settings".html_safe, [:settings, @page], class: 'btn btn-default'
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

  end
end
