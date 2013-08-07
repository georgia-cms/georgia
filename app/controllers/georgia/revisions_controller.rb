module Georgia
  class RevisionsController < Georgia::ApplicationController

    load_and_authorize_resource class: Georgia::Revision

    include Georgia::Concerns::Revisioning

    before_filter :prepare_revision, only: [:show, :edit, :update, :destroy, :copy]

    rescue_from 'ActionView::MissingTemplate' do |exception|
      render_default_template(exception.path)
    end

    def show
      redirect_to [:edit, @revision]
    end

    def edit
      build_associations
    end

    def update
      @revision.update_attributes(params[:revision])

      if @revision.valid?
        @revision.updated_by = current_user
        @revision.save
        respond_to do |format|
          format.html { redirect_to [:edit, @revision], notice: "#{decorate(@revision).title} was successfully updated." }
          format.js { render layout: false }
        end
      else
        build_associations
        respond_to do |format|
          format.html { render :edit }
          format.js { render layout: false }
        end
      end
    end

    def destroy
      @message = "#{@revision.title} was successfully deleted."
      @revision.destroy
      redirect_to @page, notice: @message
    end

    def sort
      if params[:revision]
        params[:revision].each_with_index do |id, index|
          model.update_all({position: index+1}, {id: id})
        end
      end
      render nothing: true
    end

    private

    def build_associations
      @revision.slides.build unless @revision.slides.any?
      I18n.available_locales.map(&:to_s).each do |locale|
        @revision.contents << Georgia::Content.new(locale: locale) unless @revision.contents.select{|c| c.locale == locale}.any?
        @revision.slides.each do |slide|
          slide.contents << Georgia::Content.new(locale: locale) unless slide.contents.select{|c| c.locale == locale}.any?
        end
      end
    end

    def render_default_template(path)
      render "revisions/#{path}"
    rescue ActionView::MissingTemplate
      render "georgia/revisions/#{path}"
    end

    def prepare_revision
      @page = Georgia::Page.find(params[:page_id])
      @revision = decorate(model.find(params[:id]))
    end

    def decorate revision
      Georgia::RevisionDecorator.decorate(revision)
    end
  end
end