module Georgia
  class PagesController < Georgia::ApplicationController

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Searchable

  end
end
