module Georgia
  class ReviewsController < Georgia::ApplicationController

    load_and_authorize_resource class: Georgia::Review

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Publishable
    include Georgia::Concerns::Searchable
    
  end
end