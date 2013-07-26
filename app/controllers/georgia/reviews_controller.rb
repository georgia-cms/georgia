module Georgia
  class ReviewsController < Georgia::PagesController
    load_and_authorize_resource class: Georgia::Review
  end
end