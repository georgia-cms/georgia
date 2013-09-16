require 'active_support/concern'

module Georgia
  module Concerns
    module Pageable
      extend ActiveSupport::Concern
      include Helpers

      included do

        before_filter :prepare_new_page, only: [:search, :find_by_tag]
        before_filter :prepare_page, only: [:show, :edit, :update, :copy, :preview, :destroy]

        def find_by_tag
          @pages = model.tagged_with(params[:tag]).page(params[:page])
          @pages = Georgia::PagesDecorator.decorate(@pages)
          render :index
        end

        def show
        end

        def edit
        end

        def create
          @page = model.new(slug: params[:title].try(:parameterize))
          if @page.save
            @page.revisions.create(template: Georgia.templates.first) do |rev|
              rev.contents << Georgia::Content.new(locale: I18n.default_locale, title: params[:title])
            end
            @page.update_attribute(:current_revision, @page.revisions.first)
          end
        end

        def update
          # FIXME: Throw an error if update_attributes returns false
          @page.update_attributes(params[:page])
          respond_to do |format|
            format.html { render :edit, notice: "#{decorate(@revision).title} was successfully updated." }
            format.js { render layout: false }
          end
        end

        def copy
          @copy = @page.copy
          redirect_to [:edit, @copy], notice: "Do not forget to change your url"
        end

        def preview
          redirect_to @page.url
        end

        def destroy
          @message = "#{@page.title} was successfully deleted."
          @page.destroy
          redirect_to [:search, model], notice: @message
        end

        private

        def prepare_new_page
          @page = model.new
        end

        def prepare_page
          @page = model.find(params[:id]).decorate
        end

      end

    end
  end
end
