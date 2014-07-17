module Georgia
  class MediaSearch < SearchDefinition

    private

    def default_definition
      {
        highlight: { fields: { data_file_name: {type: "plain"} } }
      }
    end

    def query_fields
      ['data_file_name', 'tag_list']
    end

  end
end