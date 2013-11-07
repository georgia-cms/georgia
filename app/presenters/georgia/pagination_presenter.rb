module Georgia
  class PaginationPresenter

    attr_accessor :view_context

    delegate :content_tag, :icon_tag, :link_to_previous_page, :link_to_next_page, :link_to, to: :view_context

    def initialize view_context, search
      @view_context = view_context
      @search = search
    end

    def to_s
      content_tag(:div, class: 'header-pagination') do
        search_count_tag + navigation_tags
      end
    end

    private

    def search_count_tag
      content_tag(:span, search_count, class: 'pagination-count')
    end

    def navigation_tags
      output = ActiveSupport::SafeBuffer.new
      output << previous_page
      output << next_page
      content_tag :div, output, class: 'btn-group'
    end

    def search_count
      page = @search.results.offset+1
      count = @search.results.last_page? ? @search.total : @search.results.offset+@search.results.per_page
      total = @search.total
      "#{page} - #{count} of #{total}"
    end

    def previous_page
      text = icon_tag('chevron-left')
      link_to_previous_page(@search.hits, text, class: btn_class) || link_to_disabled(text)
    end

    def next_page
      text = icon_tag('chevron-right')
      link_to_next_page(@search.hits, text, class: btn_class, role: 'button') || link_to_disabled(text)
    end

    def btn_class
      'btn btn-default'
    end

    def link_to_disabled text
      link_to(text, '#', class: "#{btn_class} disabled", role: 'button')
    end

  end
end