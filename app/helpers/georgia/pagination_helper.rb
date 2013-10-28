module Georgia
  module PaginationHelper

    def pagination_tag view, search
      Georgia::PaginationPresenter.new(view, search)
    end

  end
end