require 'active_support/concern'

module Georgia
  module Concerns
    module Revisionable
      extend ActiveSupport::Concern

      included do

        has_many :revisions, as: :revisionable, dependent: :destroy
        belongs_to :current_revision, class_name: Georgia::Revision, foreign_key: :revision_id

        delegate :title, :text, :excerpt, :keywords, :keyword_list, :image, to: :current_revision, allow_nil: true
        delegate :template, :content, :slides, :widgets, to: :current_revision, allow_nil: true
        delegate :draft?, :review?, :revision?, to: :current_revision, allow_nil: true

        def draft
          Georgia::Clone.new(self).draft
        end

        def store
          Georgia::Clone.new(self).store
        end

        def copy
          Georgia::Clone.new(self).copy
        end

        def approve_revision revision
          current_revision.store if current_revision
          self.update_attribute(:revision_id, revision.id)
        end

      end

    end
  end
end