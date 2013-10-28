module Georgia
  class PaginationPresenter

    attr_accessor :view_context

    delegate :content_tag, :icon_tag, :link_to_previous_page, :link_to_next_page, to: :view_context

    def initialize view_context, search
      @view_context = view_context
      @search = search
    end

    def to_s
      content_tag(:div, class: 'header-pagination') do
        content_tag(:span, search_count, class: 'pagination-count') +
        link_to_previous_page(@search.hits, icon_tag('chevron-left')) +
        link_to_next_page(@search.hits, icon_tag('chevron-right'))
      end
    end

    private

    def search_count
      page = @search.results.offset+1
      count = @search.results.last_page? ? @search.total : @search.results.offset+@search.results.per_page
      total = @search.total
      "#{page} - #{count} of #{total}"
    end

  end
end