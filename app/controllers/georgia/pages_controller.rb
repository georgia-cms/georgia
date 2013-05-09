module Georgia
  class PagesController < Georgia::ApplicationController
    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Publishable

    load_and_authorize_resource class: Georgia::Page
  end
end
