module Georgia
  class RevisionsController < Georgia::PagesController
    load_and_authorize_resource class: Georgia::Revision
  end
end