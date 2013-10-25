module Georgia
  class PagesController < ApplicationController

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Notifying
    include Georgia::Concerns::Publishing
    include Georgia::Concerns::Searchable
    include Georgia::Concerns::Sorting

  end
end
