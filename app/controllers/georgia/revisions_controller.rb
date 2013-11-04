module Georgia
  class RevisionsController < ApplicationController

    load_and_authorize_resource class: Georgia::Revision

    before_filter :prepare_page

    def index
      @revisions = @page.revisions
    end

    def show
      redirect_to [:edit, @page, @revision]
    end

    def edit
      @revision = Revision.find(params[:id])
      @ui_sections = Georgia::UiSection.all
    end

    def update
      @revision = Revision.find(params[:id])
      @revision.update_attributes(params[:revision])

      if @revision.save
        respond_to do |format|
          format.html { redirect_to [:edit, @page, @revision], notice: "#{decorate(@revision).title} was successfully updated." }
          format.js { render layout: false }
        end
      else
        respond_to do |format|
          format.html {
            build_associations
            render :edit
          }
          format.js { head :internal_server_error }
        end
      end
    end

    def destroy
      @revision = Revision.find(params[:id])
      @message = "#{@revision.title} was successfully deleted."
      @revision.destroy
      redirect_to @page, notice: @message
    end

    # Sends revision to main_app router
    # FIXME: bypass this once Georgia will be loaded on root
    def preview
      redirect_to main_app.preview_page_path(id: @page.id, revision_id: @revision.id)
    end

    def review
      @revision.review
      notify("#{current_user.name} is asking you to review #{@revision.title}.")
      redirect_to [:edit, @page, @revision], notice: "You successfully submited #{@revision.title} for review."
    end

    def approve
      @revision.approve
      message = "#{current_user.name} has successfully approved and published #{@revision.title} #{instance_name}."
      notify(message)
      redirect_to @page, notice: message
    end

    def decline
      @revision.decline
      message = "#{current_user.name} has successfully published #{@revision.title} #{instance_name}."
      notify(message)
      redirect_to [:edit, @page, @revision], notice: message
    end

    def revert
      @revision.revert
      message = "#{current_user.name} has successfully published #{@revision.title} #{instance_name}."
      notify(message)
      redirect_to @page, notice: message
    end

    private

    def prepare_page
      @page = Page.find(params[:page_id])
    end

  end
end