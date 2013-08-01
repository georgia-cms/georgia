module Georgia
  class MetaPagesController < Georgia::PagesController

    def show
      render :details
    end

    def details
      @publisher = Georgia::Publisher.new(params[:id])
      @page = Georgia::PageDecorator.decorate(@publisher.meta_page)
    end

    def create
      @page = model.new(params[:page])
      @page.slug = decorate(@page).title.try(:parameterize)
      @page.created_by = current_user
      @page.save!
    end

    def destroy
      @message = "#{@page.title} was successfully deleted."
      @publisher.pages.destroy_all
      redirect_to [:search, model], notice: @message
    end

    private

    def prepare_page
      @page = decorate(model.find_by_uuid(params[:id]))
      @publisher = Georgia::Publisher.new(@page.uuid, user: current_user)
    end

  end
end