module Georgia
  module PaginationHelper

    def pagination_tag search
      return unless search and !search.total.zero?
      Georgia::PaginationPresenter.new(self, search)
    end

  end
end