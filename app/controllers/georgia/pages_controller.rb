module Georgia
  class PagesController < Georgia::ApplicationController

    load_and_authorize_resource class: Georgia::Page

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Publishable
    include Georgia::Concerns::Searchable

  end
end
