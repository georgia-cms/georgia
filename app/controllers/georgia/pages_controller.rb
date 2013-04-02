module Georgia
  class PagesController < Georgia::ApplicationController

    include Georgia::Concerns::Publishable

    load_and_authorize_resource class: Georgia::Page

    before_filter :prepare_new_page, only: [:index, :search]

    def index
      @pages = Georgia::Page.order('updated_at DESC').page(params[:page])

      # Quick and dirty hack for visibility
      # FIXME: Please add indexed facets with Sphinx or ElasticSearch or add a new BackBone panel view
      @pages = @pages.where(template: params[:template]) if params[:template].present?

      case params[:status]
      when Georgia::Status::DRAFT
        @pages = @pages.draft
      when Georgia::Status::PUBLISHED
        @pages = @pages.published
      when Georgia::Status::PENDING_REVIEW
        @pages = @pages.pending_review
      end

      @pages = @pages.decorate
    end

    def search
      @pages = Georgia::Page.search(params[:query]).page(params[:page]).decorate
      if @pages.length == 1
        redirect_to page_path(@pages.first)
      else
        render :index
      end
    end

    def show
      redirect_to edit_page_path(params[:id])
    end

    def edit
      @page = Georgia::Page.find(params[:id], include: :contents).decorate
      build_associations
    end

    def create
      @page = Georgia::Page.new(params[:page])
      @page.slug = @page.decorate.title.try(:parameterize)
      @page.created_by = current_user
      @page.save
    end

    def update
      @page = Georgia::Page.find(params[:id]).decorate
      @page.update_attributes(params[:page])

      if @page.valid?
        @page.updated_by = current_user
        @page.save
        respond_to do |format|
          format.html { redirect_to [:edit, @page], notice: "#{@page.decorate.title} was successfully updated." }
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
      @page = Georgia::Page.find(params[:id])

      if @page.destroy
        unless (request.referer == page_url(@page)) or (request.referer == edit_page_url(@page))
          redirect_to :back, notice: "#{@page.decorate.title} was successfully deleted."
        else
          redirect_to pages_url, notice: "#{@page.decorate.title} was successfully deleted."
        end
      else
        redirect_to pages_url, alert: 'Oups. Something went wrong.'
      end
    end

    def sort
      if params[:page]
        params[:page].each_with_index do |id, index|
          Page.update_all({position: index+1}, {id: id})
        end
      end
      render nothing: true
    end

    protected

    def build_associations
      @page.slides.build unless @page.slides.any?
      I18n.available_locales.map(&:to_s).each do |locale|
        @page.contents << Georgia::Content.new(locale: locale) unless @page.contents.select{|c| c.locale == locale}.any?
        @page.slides.each do |slide|
          slide.contents << Georgia::Content.new(locale: locale) unless slide.contents.select{|c| c.locale == locale}.any?
        end
      end
    end

    def prepare_new_page
      @page = Georgia::Page.new
      @page.contents = [Georgia::Content.new(locale: I18n.default_locale)]
    end

  end

end