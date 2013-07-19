require 'active_support/concern'

module Georgia
  module Concerns
    module Revisionable
      extend ActiveSupport::Concern

      included do
        has_many :revisions, foreign_key: :uuid, primary_key: :uuid

        def store_as_revision
          Georgia::Revision.store(self)
        end

      end

      module ClassMethods

      end
    end
  end
end