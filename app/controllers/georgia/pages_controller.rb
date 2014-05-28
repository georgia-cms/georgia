module Georgia
  class PagesController < ApplicationController

    include Georgia::Concerns::Helpers

    # load_and_authorize_resource class: Georgia::Page

    before_filter :prepare_new_page, only: [:search]
    before_filter :prepare_page, only: [:show, :edit, :settings, :update, :copy, :preview, :draft]

    def show
      redirect_to [:edit, @page]
    end

    # Edit current revision
    def edit
      redirect_to [:edit, @page, @page.current_revision]
    end

    # Edit current page
    def settings
    end

    # Create page, load first current revision and js redirect to revisions#edit
    def create
      @page = model.new(slug: params[:title].try(:parameterize))
      if @page.save
        @page.revisions.create(template: Georgia.templates.first) do |rev|
          rev.contents << Georgia::Content.new(locale: I18n.default_locale, title: params[:title])
        end
        @page.update_attribute(:current_revision, @page.revisions.first)
        respond_to do |format|
          format.html { redirect_to edit_page_revision_path(@page, @page.current_revision), notice: "#{@page.title} was successfully created." }
          format.js { render layout: false }
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, alert: "Oups. Something went wrong." }
          format.js { render layout: false }
        end
      end
    end

    # Update page settings
    def update
      model.update_tree(params[:page_tree]) if params[:page_tree]
      if @page.update(page_params)
        respond_to do |format|
          format.html { render :settings, notice: "#{@page.title} was successfully updated." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to [:settings, @page], notice: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end
    end

    # Creates a copy of a page and redirects to its revisions#edit
    def copy
      @copy = @page.copy
      redirect_to edit_page_revision_path(@copy, @copy.current_revision), notice: "#{instance_name.humanize} successfully copied. Do not forget to change your url"
    end

    # Destroys page and its revisions from page
    # Also used to destroy multiple pages from table checkboxes
    def destroy
      back_url = url_for(controller: controller_name, action: :search)
      @pages = model.where(id: params[:id])
      if @pages.destroy_all
        respond_to do |format|
          format.html { redirect_to back_url, notice: "#{instance_name.humanize} successfully deleted." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to back_url, alert: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end
    end

    # Publishes multiple pages from table checkboxes
    def publish
      @pages = model.where(id: params[:id])

      unless @pages.map(&:publish).include?(false)
        respond_to do |format|
          format.html { redirect_to :back, notice: "Successfully published." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, alert: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end
    end

    # Unpublishes the page
    def unpublish
      @pages = model.where(id: params[:id])

      unless @pages.map(&:unpublish).include?(false)
        respond_to do |format|
          format.html { redirect_to :back, notice: "Successfully unpublished." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, alert: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end
    end

    # Sorts subpages/children from pages#settings
    # FIXME: This should be taken care of in pages#update
    def sort
      if params[:page]
        params[:page].each_with_index do |id, index|
          model.update_all({position: index+1}, {id: id})
        end
      end
      render nothing: true
    end

    def index
      redirect_to [:search, model]
    end

    def search
      session[:search_params] = params
      search_conditions = model.search_conditions(params)
      @search = model.search(search_conditions).page(params[:page])
      @pages = Georgia::PageDecorator.decorate_collection(@search.records)
    end

    private

    def prepare_new_page
      @page = model.new
    end

    def prepare_page
      @page = model.find(params[:id]).decorate
    end

    def page_params
      params.require(:page).permit(:slug)
    end

  end
end
