module Georgia
  class MediaSearch < SearchDefinition

    def process
      add_fulltext_query_filter if query.present?
      add_default_sorting unless query.present?
    end

    private

    def default_definition
      {
        highlight: { fields: { data_file_name: {type: "plain"} } }
      }
    end

    def add_default_sorting
      @definition[:sort] = { updated_at: :desc }
    end

    def add_fulltext_query_filter
      @definition[:query] = {multi_match: {query: query, fields: ['data_file_name', 'tag_list']}}
    end

  end
end