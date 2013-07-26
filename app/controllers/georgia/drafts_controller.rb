module Georgia
  class DraftsController < Georgia::PagesController
    load_and_authorize_resource class: Georgia::Draft
  end
end