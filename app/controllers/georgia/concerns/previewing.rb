require 'active_support/concern'

module Georgia
  module Concerns
    module Previewing
      extend ActiveSupport::Concern
      include Helpers

      included do

        def preview
          redirect_to main_app.preview_page_path(id: @page.id, revision_id: @revision.id)
        end

      end
    end
  end
end