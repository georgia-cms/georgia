module Georgia
  class PageSearch < SearchDefinition

    private

    def post_process
      @type = params[:type]
      filters << pages_filter if @type == 'Georgia::Page'
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

    def pages_filter
      {missing: {field: 'type'}}
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

  end
end