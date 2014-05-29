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
      SearchCount.new(@search).to_s
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

    class SearchCount

      def initialize(search)
        @search = search
      end

      def to_s
        "#{from} - #{to} of #{total}"
      end

      private

      def from
        if @search.first_page?
          1
        else
          (page-1)*records_per_page+1
        end
      end

      def to
        if @search.first_page?
          @search.size
        else
          from+@search.size-1
        end
      end

      def total
        @search.total_count
      end

      def page
        @search.current_page
      end

      def records_per_page
        @search.limit_value
      end
    end

  end
end