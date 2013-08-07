require 'active_support/concern'

module Georgia
  module Concerns
    module Revisionable
      extend ActiveSupport::Concern

      included do

        has_many :revisions, as: :revisionable, dependent: :destroy
        belongs_to :current_revision, class_name: Georgia::Revision, foreign_key: :revision_id

        delegate :title, :text, :excerpt, :keywords, :keyword_list, :image, to: :current_revision, allow_nil: true
        delegate :content, to: :current_revision

        delegate :draft?, :review?, :published?, :revision?, to: :current_revision

        def draft
          revision = Georgia::Clone.new(self).draft
          self.revisions << revision
          revision
        end

        def publish(revision)
          self.update_attribute(:revision_id, revision.id)
        end

      end

    end
  end
end