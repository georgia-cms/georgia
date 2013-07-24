module Georgia
  class MetaPagesController < Georgia::ApplicationController

    load_and_authorize_resource class: Georgia::MetaPage

    include Georgia::Concerns::Pageable
    include Georgia::Concerns::Publishable
    include Georgia::Concerns::Searchable

    def show
      @page = Georgia::PageDecorator.decorate(Georgia::MetaPage.find(params[:id]))
    end

  end
end
