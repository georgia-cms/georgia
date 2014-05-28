module Georgia
  module PaginationHelper

    def pagination_tag search, options={}
      Georgia::PaginationPresenter.new(self, search, options)
    end

  end
end