module Georgia
  class PaginationPresenter < Presenter

    def initialize view_context, search, options
      super
      @search = search
      @options = options
    end

    def to_s
      return unless @search and !@search.total_count.zero?
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
      page = @search.current_page
      count = @search.last_page? ? @search.total_count : page+(@search.max_per_page or @search.default_per_page)
      total = @search.total_count
      "#{page} - #{count} of #{total}"
    end

    def previous_page
      text = icon_tag('chevron-left')
      link_to_previous_page(@search.records, text, class: btn_class, params: params) || link_to_disabled(text)
    end

    def next_page
      text = icon_tag('chevron-right')
      link_to_next_page(@search.records, text, class: btn_class, role: 'button', params: params) || link_to_disabled(text)
    end

    def btn_class
      'btn btn-default'
    end

    def link_to_disabled text
      link_to(text, '#', class: "#{btn_class} disabled", role: 'button')
    end

  end
end