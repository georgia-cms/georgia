module Georgia
  class PagesController < Georgia::ApplicationController

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Searchable

    def sort
      if params[:page]
        params[:page].each_with_index do |id, index|
          model.update_all({position: index+1}, {id: id})
        end
      end
      render nothing: true
    end

  end
end
