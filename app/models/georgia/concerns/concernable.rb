require 'active_support/concern'

module Georgia
  module Concerns
    module Concernable
      extend ActiveSupport::Concern

      included do
        # Defines helper methods for available actions on classes extending concerns. Default value is false until the concern itself redefines the method and set to true
        [:publishable?, :unpublishable?, :approvable?, :previewable?, :reviewable?, :draftable?, :approvable?].each do |action|
          define_method(action){false}
        end
      end

    end
  end
end