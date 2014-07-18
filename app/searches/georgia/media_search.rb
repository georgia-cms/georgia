module Georgia
  class MediaSearch < SearchDefinition

    def post_process
      filter_by_types
      filter_by_tags
      apply_filtering
    end

    private

    def apply_filtering
      add_filters_to_query if filters.any?
    end

    def add_fulltext_query_filter
      @definition[:query][:filtered][:query] = {multi_match: {query: query, fields: query_fields}}
    end

    def filter_by_types
      @types = @params.fetch(:only, [])
      filters << pictures_filter if @types.include?(:pictures)
    end

    def filter_by_tags
      @tags = @params.fetch(:tg, [])
      filters << tags_filter if @tags.any?
    end

    def pictures_filter
      {term: {type: 'Ckeditor::Picture'}}
    end

    def tags_filter
      {terms: {tag_list: @tags, execution: 'bool'}}
    end

    def default_definition
      {
        query: { filtered: { filter: {bool: {must: []}}} },
        highlight: { fields: { data_file_name: {type: "plain"} } }
      }
    end

    def query_fields
      ['data_file_name', 'tag_list']
    end

  end
end