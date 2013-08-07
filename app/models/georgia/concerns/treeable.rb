require 'active_support/concern'

module Georgia
  module Concerns
    module Treeable
      extend ActiveSupport::Concern

      included do

        has_ancestry orphan_strategy: :rootify
        attr_accessible :parent_id

      end
    end
  end
end
