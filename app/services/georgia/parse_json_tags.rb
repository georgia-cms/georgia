module Georgia
  class ParseJsonTags

    def initialize params, key: :tag_list
      @params = params
      @key    = key
    end

    def call
      parse_json_tags!
      @params
    end

    private

    def parse_json_tags!
      @params[@key] = JSON.parse(@params[@key]) if @params.fetch(@key, nil)
    end

  end
end