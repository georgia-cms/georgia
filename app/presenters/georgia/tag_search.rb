module Georgia
  class TagSearch < SearchDefinition

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
      add_sorting
    end

    private

    def sort_column
      :taggings_count
    end
    def sort_direction
      'asc'
    end

    def query_fields
      ['name']
    end
  end
end