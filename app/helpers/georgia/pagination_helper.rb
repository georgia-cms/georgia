module Georgia
  module PaginationHelper

    def pagination_tag view, search
      return unless search and !search.total.zero?
      Georgia::PaginationPresenter.new(view, search)
    end

  end
end