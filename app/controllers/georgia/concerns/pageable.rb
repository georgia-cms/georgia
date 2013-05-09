require 'active_support/concern'

module Georgia
  module Concerns
    module Pageable
      extend ActiveSupport::Concern
      include Georgia::Concerns::Searchable

      included do
        before_filter :prepare_new_page, only: [:search, :find_by_tag]
        rescue_from 'ActionView::MissingTemplate' do |exception|
          render_default_template(exception.path)
        end
      end


      def render_default_template(path)
        render "pages/#{path}"
      rescue ActionView::MissingTemplate
        render "georgia/pages/#{path}"
      end

      def index
        redirect_to action: :search
      end

      def find_by_tag
        @pages = model.tagged_with(params[:tag]).page(params[:page]).decorate
        render :index
      end

      def show
        redirect_to edit_page_path(params[:id])
      end

      def edit
        @page = model.find(params[:id], include: :contents).decorate
        build_associations
      end

      def create
        @page = model.new(params[:page])
        @page.slug = @page.decorate.title.try(:parameterize)
        @page.created_by = current_user
        @page.save
      end

      def update
        @page = model.find(params[:id]).decorate
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
        @page = model.find(params[:id])

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
        @page = model.new
        @page.contents = [Georgia::Content.new(locale: I18n.default_locale)]
      end
    end
  end
end
