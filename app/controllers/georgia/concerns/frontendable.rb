require 'active_support/concern'

module Georgia
  module Concerns
    module Frontendable
      extend ActiveSupport::Concern

      included do

        # Loads the page according to request url
        # Restore the latest published revision of the given page
        def show
          if preview?
            prepare_preview
          else
            @page = Georgia::Page.from_url(params[:request_path]).published.first || not_found
            @page = Georgia::PageDecorator.decorate(@page)
          end
        end

        protected

        def preview?
          params[:r].present?
        end

        # Loads the page according to given id
        # Temporarily set the given revision to preview as the 'current_revision'
        def prepare_preview
          @page = Georgia::Page.from_url(params[:request_path]).first || not_found
          @page = Georgia::PageDecorator.decorate(@page)
          @page.current_revision = Georgia::Revision.find(params[:r])
          authorize! :preview, @page
        end

        # Triggers a 404 page not found
        # Use when provided url doesn't match any the Georgia::Pages
        def not_found
          raise ActionController::RoutingError.new('Not Found')
        end

        def page_cache_key
          [Georgia::Page.where(url: "/#{params[:request_path]}").try(:first).try(:cache_key), I18n.locale].compact.join('/')
        end

      end

    end
  end
end