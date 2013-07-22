require 'active_support/concern'

module Georgia
  module Concerns
    module Previewable
      extend ActiveSupport::Concern

      included do

        def preview_url
          @preview_url = "#{self.url}?preview=1"
        end

      end

    end
  end
end