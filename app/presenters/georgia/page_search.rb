module Georgia
  class PageSearch < SearchDefinition

    def sort_column
      :updated_at
    end

    def sort_direction
      'desc'
    end

  end
end