require 'active_support/concern'

module Georgia
  module Concerns
    module Taggable
      extend ActiveSupport::Concern

      included do

        # acts_as_taggable_on :tags
        # attr_accessible :tag_list if needs_attr_accessible?

      end

      module ClassMethods
      end
    end
  end
end