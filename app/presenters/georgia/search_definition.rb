module Georgia
  class SearchDefinition

    attr_reader :params, :definition, :query, :sort_column, :sort_direction

    def initialize params
      @params = params
      @query = params.fetch(:query, nil)
      @query ||= params.fetch(:q, nil)
      @sort_column = params.fetch(:sort, nil)
      @sort_direction = params.fetch(:direction, nil)
      @definition = default_definition
      process
    end

    def process
      if query.present?
        include_filtered_query
        add_fulltext_query
        # add_suggestion
        # add_status_facet_filter if status.present?
      # elsif status.present?
        # include_filtered_query
        # add_status_facet_filter
      else
        add_match_all
      end
    end

    private

    def add_fulltext_query
      add_to_query_definition({multi_match: { query: query, fields: query_fields }})
    end

    def add_match_all
      @definition[:query] = { match_all: {} }
      @definition[:sort] = { sort_column => sort_direction }
    end

    def add_sorting
      @definition[:sort] = { sort_column => sort_direction }
      @definition[:track_scores] = true
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

    def add_status_facet_filter
      add_to_query_definition({ term: {status: status} })
      @definition[:facets][:status][:facet_filter] = {term: {status: status}}
    end

    def add_to_query_definition conditions
      @definition[:query][:filtered][:query][:bool][:must] << conditions
    end

    def default_definition
      {
        query: { }
      }
    end

    def include_filtered_query
      @definition[:query] = {filtered: {query: {bool: {must: []}}}}
    end

    def query_fields
      ['title^5', 'text']
    end

  end
end