module Georgia
  module MetaTagsHelper

    def meta_title title
      site_title = ""
      site_title << "#{title} | " unless title.blank?
      site_title << Georgia.title
      content_tag :title, site_title
    end

    def meta_description description
      return unless description
      tag :meta, name: 'description', content: description
    end

    def meta_keywords keywords
      return unless keywords
      tag :meta, name: 'keywords', content: keywords
    end

  end
end