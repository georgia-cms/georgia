require 'active_support/concern'

module Georgia
  module Concerns
    module Pageable
      extend ActiveSupport::Concern
      include Helpers

      included do

        before_filter :prepare_new_page, only: [:search, :find_by_tag]

        def find_by_tag
          @pages = model.tagged_with(params[:tag]).page(params[:page])
          @pages = Georgia::PagesDecorator.decorate(@pages)
          render :index
        end

        def show
          @page = model.find(params[:id]).decorate
        end

        def edit
          @page = model.find(params[:id]).decorate
        end

        def create
          @page = model.new(slug: params[:title].try(:parameterize))
          if @page.save
            @page.revisions.create(template: 'one-column') do |rev|
              rev.contents << Georgia::Content.new(locale: I18n.default_locale, title: params[:title])
            end
            @page.update_attribute(:current_revision, @page.revisions.first)
          end
        end

        def copy
          @copy = @page.copy
          redirect_to [:edit, @copy], notice: "Do not forget to change your url"
        end

        def preview
          @page = model.find(params[:id])
          redirect_to @page.url
        end

        def destroy
          @page = model.find(params[:id])
          @message = "#{@page.title} was successfully deleted."
          @page.destroy
          redirect_to [:search, model], notice: @message
        end

        def draft
          @page = model.find(params[:id])
          @draft = @page.draft
          redirect_to [:edit, @page, @draft], notice: "You successfully started a new draft of #{@draft.title}. Submit for review when completed."
        end

        def publish
          @page = model.find(params[:id])
          @page.current_revision.publish
          message = "#{current_user.name} has successfully published #{@page.title} #{instance_name}."
          notify(message)
          redirect_to :back, notice: message
        end

        def unpublish
          @page = model.find(params[:id])
          @page.current_revision.unpublish
          message = "#{current_user.name} has successfully unpublished #{@page.title} #{instance_name}."
          notify(message)
          redirect_to :back, notice: message
        end

        private

        def prepare_new_page
          @page = model.new
        end

      end

    end
  end
end
