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

    def filter_by_types
      @types = @params.fetch(:only, [])
      filters << pictures_filter if @types.include?(:pictures)
    end

    def filter_by_tags
      @tags = @params.fetch(:tg, [])
      filters << tags_filter if @tags.any?
    end

    def pictures_filter
      {term: {image?: true}}
    end

    def tags_filter
      {terms: {tag_list: @tags}}
    end

    def query_fields
      ['data_file_name', 'tag_list']
    end

  end
end