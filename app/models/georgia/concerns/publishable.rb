require 'active_support/concern'

module Georgia
  module Concerns
    module Publishable
      extend ActiveSupport::Concern

      included do

        scope :published, where(public: true)

        def publish
          self.update_attribute(:public, true)
        end

        def unpublish
          self.update_attribute(:public, false)
        end

        def public?
          self.public
        end
        alias_method :published?, :public?

        def publish_state
          public? ? 'public' : 'private'
        end

      end

      module ClassMethods
      end
    end
  end
end