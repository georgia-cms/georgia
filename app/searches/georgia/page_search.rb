module Georgia
  class PageSearch < SearchDefinition

    private

    def post_process
      filters << only_pages_filter if pages_controller?
      add_filters_to_query
    end

    def query_fields
      ['title^5', 'tag_list^3', 'keyword_list^2', 'text', 'excerpt', 'template', 'slug']
    end

    def sort_column
      :updated_at
    end

    def sort_direction
      'desc'
    end

    def only_pages_filter
      {missing: { field: 'type' }}
    end

    def add_suggestion
      @definition[:suggest] = {
        text: query,
        suggest_title: {
          term: {
            field: 'title.tokenized',
            suggest_mode: 'always'
          }
        },
        suggest_body: {
          term: {
            field: 'text.tokenized',
            suggest_mode: 'always'
          }
        }
      }
    end

    def pages_controller?
      params[:controller] == 'georgia/pages'
    end

  end
end