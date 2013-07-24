require 'active_support/concern'

module Georgia
  module Concerns
    module Pageable
      extend ActiveSupport::Concern
      include Helpers

      included do
        before_filter :prepare_new_page, only: [:search, :find_by_tag]

        rescue_from 'ActionView::MissingTemplate' do |exception|
          render_default_template(exception.path)
        end

        def find_by_tag
          @pages = model.tagged_with(params[:tag]).page(params[:page])
          @pages = Georgia::PagesDecorator.decorate(@pages)
          render :index
        end

        def show
          @page = model.find(params[:id])
          redirect_to [:edit, @page]
        end

        def edit
          @page = model.find(params[:id], include: :contents)
          @page = Georgia::PageDecorator.decorate(@page)
          build_associations
        end

        def create
          @page = model.new(params[:page])
          @page.slug = decorate(@page).title.try(:parameterize)
          @page.created_by = current_user
          @page.save!
        end

        def update
          @page = model.find(params[:id])
          @page = decorate(@page)
          @page.update_attributes(params[:page])

          if @page.valid?
            @page.updated_by = current_user
            @page.save
            respond_to do |format|
              format.html { redirect_to [:edit, @page], notice: "#{decorate(@page).title} was successfully updated." }
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
          @message = "#{@page.title} was successfully deleted."
          @page.destroy
          redirect_to [:search, model], notice: @message
        end

        def copy
          @page = model.find(params[:id])
          @copy = @page.copy
          redirect_to [:edit, @copy], notice: "Do not forget to change your url"
        end

        def sort
          if params[:page]
            params[:page].each_with_index do |id, index|
              model.update_all({position: index+1}, {id: id})
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

        private

        def render_default_template(path)
          render "pages/#{path}"
        rescue ActionView::MissingTemplate
          render "georgia/pages/#{path}"
        end

        def decorate page
          Georgia::PageDecorator.decorate(page)
        end
      end

    end
  end
end
