require 'active_support/concern'

module Georgia
  module Concerns
    module Previewable
      extend ActiveSupport::Concern

      included do

        def previewable?
          true
        end

      end

    end
  end
end