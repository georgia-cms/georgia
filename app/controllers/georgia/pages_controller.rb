module Georgia
  class PagesController < Georgia::ApplicationController

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Publishable
    include Georgia::Concerns::Searchable

  end
end
