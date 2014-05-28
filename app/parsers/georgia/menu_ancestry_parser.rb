module Georgia
  class MenuAncestryParser

    def initialize serialized_string
      @ancestry = serialized_string
    end

    def to_hash
      pairs = split_parent_child_pairs
      parsed_hash = {}
      pairs.each_with_index do |p, index|
        attributes = LinkAttributes.new(p)
        parsed_hash[attributes.id] = {position: index+1, parent_id: attributes.parent_id}
      end
      parsed_hash
    end

    private

    def split_parent_child_pairs
      @ancestry.split('&')
    end

    class LinkAttributes

      def initialize serialized_string
        @serialized_string = serialized_string
      end

      def id
        @serialized_string.split('=')[0][5..-2]
      end

      def parent_id
        parent_id = @serialized_string.split('=')[1]
        parent_id == 'null' ? nil : parent_id.to_i
      end
    end

  end
end