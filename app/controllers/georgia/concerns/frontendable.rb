require 'active_support/concern'

module Georgia
  module Concerns
    module Frontendable
      extend ActiveSupport::Concern

      included do

        caches_action :show, cache_path: :page_cache_key.to_proc
        cache_sweeper :navigation_sweeper, only: :show

        # Loads the page according to request url
        # Restore the latest published revision of the given page
        def show
          @page = Georgia::Page.where(url: "/#{params[:request_path]}").includes(current_revision: :contents).published.first || not_found
          @page = Georgia::PageDecorator.decorate(@page)
        end

        # Loads the page according to given id
        # Temporarily set the given revision to preview as the 'current_revision'
        def preview
          @page = Georgia::Page.find(params[:id]).decorate
          @page.current_revision = Georgia::Revision.find(params[:revision_id])
          authorize! :preview, @page
          render :show
        end

        protected

        # Triggers a 404 page not found
        # Use when provided url doesn't match any the Georgia::Pages
        def not_found
          raise ActionController::RoutingError.new('Not Found')
        end

        def page_cache_key
          Georgia::Page.where(url: "/#{params[:request_path]}").first.cache_key
        end

      end

    end
  end
end