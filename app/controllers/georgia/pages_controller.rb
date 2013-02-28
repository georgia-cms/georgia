module Georgia
  class PagesController < Georgia::ApplicationController

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
      # @page.created_by = current_user
      @page.save
    end

    def update
      @page = Page.find(params[:id]).decorate
      @page.update_attributes(params[:page])

      if @page.valid?
        @page.updated_by = current_user
        @page.save
        redirect_to [:edit, @page], notice: "#{@page.decorate.title} was successfully updated."
      else
        build_associations
        render :edit
      end
    end

    def destroy
      @page = Georgia::Page.find(params[:id])

      if @page.destroy
        redirect_to :back, notice: "#{@page.decorate.title} was successfully deleted." and return unless request.referer == page_path(@page)
        redirect_to pages_url, notice: "#{@page.decorate.title} was successfully deleted."
      else
        redirect_to pages_url, alert: 'Oups. Something went wrong.'
      end
    end

    def publish
      @page = Georgia::Page.find(params[:id]).decorate
      @page.store_revision do
        @page.publish current_user
        @page.save!
      end
      # Notifier.notify_users(@page, "#{current_user.name} has published the job '#{@page.title}'").deliver
      redirect_to :back, notice: "'#{@page.title}' was successfully published."
    end

    def unpublish
      @page = Georgia::Page.find(params[:id]).decorate
      @page.unpublish
      if @page.save
        # Notifier.notify_users(@page, "#{current_user.name} has unpublished the job '#{@page.title}'").deliver
        redirect_to :back, notice: "'#{@page.title}' was successfully unpublished."
      else
        render :edit
      end
    end

    def ask_for_review
      @page = Georgia::Page.find(params[:id]).decorate
      @page.wait_for_review
      if @page.save
        # Notifier.notify_editors(@page, "#{current_user.name} is asking you to review job '#{@page.title}'").deliver
        respond_to do |format|
          format.html {redirect_to :back, notice: "You have succesfully asked for a review."}
          format.js { render layout: false }
        end
      else
        respond_to do |format|
          format.html {redirect_to :back, error: "Something went wrong."}
          format.js { render layout: false }
        end
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