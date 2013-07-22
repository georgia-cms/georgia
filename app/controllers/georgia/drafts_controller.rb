module Georgia
  class DraftsController < Georgia::ApplicationController

    load_and_authorize_resource class: Georgia::Draft

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Publishable
    include Georgia::Concerns::Searchable
  end
end
