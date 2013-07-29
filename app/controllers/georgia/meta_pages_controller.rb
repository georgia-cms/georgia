module Georgia
  class MetaPagesController < Georgia::PagesController

    load_and_authorize_resource class: Georgia::MetaPage

    include Georgia::Concerns::Publishable

    def details
      @publisher = Georgia::Publisher.new(params[:id])
      @page = Georgia::PageDecorator.decorate(@publisher.meta_page)
    end

  end
end