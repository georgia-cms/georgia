module Georgia
  module PaginationHelper

    def search_count search
      page = search.results.offset+1
      count = search.results.last_page? ? search.total : search.results.offset+search.results.per_page
      total = search.total
      "#{page} - #{count} of #{total}"
    end

  end
end