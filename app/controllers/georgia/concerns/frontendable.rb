require 'active_support/concern'

module Georgia
  module Concerns
    module Frontendable
      extend ActiveSupport::Concern

      included do
        load_and_authorize_resource class: Georgia::Page

        # Loads the page according to request url
        # Restore the latest published revision of the given page
        def show
          @page = Georgia::Page.find_by_url(request.path)

          if params[:preview] and can? :preview, Georgia::Page
            #TODO: Should display a message somewhere to advise that this is a preview version only seen by admins
          else
            # Restore the latest published revision of the given page
            #@page = @page.reify
            not_found unless @page and @page.published?
          end

          @page = @page.decorate
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