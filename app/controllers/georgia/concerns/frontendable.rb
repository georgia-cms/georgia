require 'active_support/concern'

module Georgia
  module Concerns
    module Frontendable
      extend ActiveSupport::Concern

      included do
        load_and_authorize_resource class: Georgia::Page

        before_filter :prepare_menus

        # Loads the page according to request url
        # Restore the latest published revision of the given page
        def show
          @page = Georgia::Page.find_by_url(request.path)

          if params[:preview] and can? :preview, Georgia::Page
            #TODO: Should display a message somewhere to advise that this is a preview version only seen by admins
          else
            #@page = @page.reify  # Restore the latest published revision of the given page
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

        def prepare_menus
          @main_menu = Georgia::Menu.find_by_name('Main', include: {links: :contents})
          @footer_menu = Georgia::Menu.find_by_name('Footer', include: {links: :contents})
        end
      end

    end
  end
end