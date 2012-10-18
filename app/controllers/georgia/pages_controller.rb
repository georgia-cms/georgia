module Georgia
  class PagesController < Georgia::ApplicationController

    load_and_authorize_resource class: Georgia::Page

    def index
      @pages = Georgia::PageDecorator.decorate(Page.order('updated_at DESC').page(params[:page]))
    end

    def show
      redirect_to edit_page_path(params[:id])
    end

    def new
      @page = Georgia::PageDecorator.decorate(Page.new)
      build_associations
    end

    def edit
      @page = Georgia::PageDecorator.decorate(Page.find(params[:id]))
      build_associations
    end

    def create
      @page = Georgia::PageDecorator.decorate(Page.new(params[:page]))

      if @page.save
        redirect_to [:edit, @page], notice: 'Page was successfully created.'
      else
        build_associations
        render action: :new
      end
    end

    def update
      @page = Georgia::PageDecorator.decorate(Page.find(params[:id]))

      if @page.update_attributes(params[:page])
        redirect_to [:edit, @page], notice: 'Page was successfully updated.'
      else
        build_associations
        render action: :edit
      end
    end

    def destroy
      @page = Page.find(params[:id])

      if @page.destroy
        redirect_to pages_url, notice: 'Page was successfully deleted.'
      else
        redirect_to pages_url, notice: 'Oups. Something went wrong.'
      end
    end

    def preview
      @page = Page.find(params[:id])
      @page.attributes = params[:page]
      @page = Georgia::PageDecorator.new(@page)
      render 'pages/show', layout: 'application'
    end

    def publish
      @page = Georgia::PageDecorator.decorate(Page.find(params[:id]))
      @page.publish current_user
      if @page.save
        # Notifier.notify_users(@page, "#{current_user.name} has published the job '#{@page.title}'").deliver
        redirect_to :back, notice: "'#{@page.title}' was successfully published."
      else
        render :edit
      end
    end

    def unpublish
      @page = Georgia::PageDecorator.decorate(Page.find(params[:id]))
      @page.unpublish
      if @page.save
        # Notifier.notify_users(@page, "#{current_user.name} has unpublished the job '#{@page.title}'").deliver
        redirect_to :back, notice: "'#{@page.title}' was successfully unpublished."
      else
        render :edit
      end
    end

    def ask_for_review
      @page = Georgia::PageDecorator.decorate(Page.find(params[:id]))
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
      I18n.available_locales.each do |locale|
        @page.contents << Content.new(locale: locale.to_s) unless @page.contents.find_by_locale(locale.to_s).present?
        @page.slides.each do |slide|
          slide.contents << Content.new(locale: locale.to_s) unless slide.contents.find_by_locale(locale.to_s).present?
        end
      end
    end

  end

end