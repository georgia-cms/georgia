module Georgia
  class RevisionsController < Georgia::ApplicationController

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
      build_associations
    end

    def update
      @revision.update_attributes(params[:revision])

      if @revision.valid?
        @revision.save
        respond_to do |format|
          format.html { redirect_to [:edit, @page, @revision], notice: "#{decorate(@revision).title} was successfully updated." }
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
      @revision = decorate(model.find(params[:id]))
      @page = @revision.revisionable
    end

    def decorate revision
      Georgia::RevisionDecorator.decorate(revision)
    end

  end
end