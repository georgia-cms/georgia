require 'active_support/concern'

module Georgia
  module Concerns
    module Frontendable
      extend ActiveSupport::Concern

      included do

        # Loads the page according to request url
        # Restore the latest published revision of the given page
        def show
          @page = Georgia::MetaPage.where(url: request.path).published.first || not_found
          @page = Georgia::PageDecorator.decorate(@page)
        end

        def preview
          @page = Georgia::Page.find(params[:id])
          @page = Georgia::PageDecorator.decorate(@page)
          authorize! :preview, @page
          render :show
        end

        protected

        # Triggers a 404 page not found
        # Use when provided url doesn't match any the Georgia::Pages
        def not_found
          raise ActionController::RoutingError.new('Not Found')
        end
      end

    end
  end
end