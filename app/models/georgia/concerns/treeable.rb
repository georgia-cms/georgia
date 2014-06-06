require 'active_support/concern'

module Georgia
  module Concerns
    module Treeable
      extend ActiveSupport::Concern

      included do

        has_ancestry orphan_strategy: :rootify
        attr_accessible :parent_id if needs_attr_accessible?

      end

      module ClassMethods

        def update_tree(tree)
          tree.each do |id, attributes|
            update(id, attributes)
          end
        end

      end
    end
  end
end
