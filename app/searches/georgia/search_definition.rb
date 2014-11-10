module Georgia
  class SearchDefinition

    attr_reader :params, :definition, :query

    DEFAULT_SORT_COLUMN    = :updated_at
    DEFAULT_SORT_DIRECTION = 'desc'

    def initialize params
      @params = params
      @query = params.fetch(:query) { params.fetch(:q, nil) }
      @sort_column = params.fetch(:sort, nil)
      @sort_direction = params.fetch(:direction, nil)
      @definition = default_definition
      process
      post_process
    end

    private

    def process
      add_fulltext_query_filter if query.present?
      add_sorting unless query.present?
    end

    def post_process
    end

    def filters
      @filters ||= []
    end

    def add_filters_to_query
      @definition[:query][:filtered][:filter][:bool][:must] = filters
    end

    def add_fulltext_query_filter
      @definition[:query][:filtered][:query] = {simple_query_string: { query: query, fields: query_fields}}
    end

    def add_sorting
      @definition[:sort] = { sort_column => sort_direction }
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
        query: { filtered: { filter: {bool: {must: []}}} }
      }
    end

    def query_fields
      []
    end

    def sort_column
      @sort_column || DEFAULT_SORT_COLUMN
    end
    def sort_direction
      @sort_direction || DEFAULT_SORT_DIRECTION
    end

  end
end