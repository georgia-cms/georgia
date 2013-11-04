module Georgia
  class RevisionsController < ApplicationController

    load_and_authorize_resource class: Georgia::Revision

    include Georgia::Concerns::Notifying
    include Georgia::Concerns::Revisioning
    include Georgia::Concerns::Previewing

    before_filter :prepare_revision

    rescue_from 'ActionView::MissingTemplate' do |exception|
      render_default_template(exception.path)
    end

    def show
      redirect_to [:edit, @page, @revision]
    end

    def edit
      @ui_sections = Georgia::UiSection.all
    end

    def update
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
      @message = "#{@revision.title} was successfully deleted."
      @revision.destroy
      redirect_to @page, notice: @message
    end

    private

    def render_default_template(path)
      render "revisions/#{path}"
    rescue ActionView::MissingTemplate
      render "georgia/revisions/#{path}"
    end

    def prepare_revision
      @revision = Revision.find(params[:id])
      @page = Page.find(params[:page_id])
    end

  end
end