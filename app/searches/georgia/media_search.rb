module Georgia
  class MediaSearch < SearchDefinition

    def initialize params
      super(params)
      extract_types
    end

    def post_process
      filters = []
      filters << pictures_filter if @types and @types.include?(:pictures)
      add_filters_to_query(filters) if filters.any?
    end

    private

    def pictures_filter
      {term: {type: 'Ckeditor::Picture'}}
    end

    def extract_types
      @types = @params.fetch(:only, [])
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