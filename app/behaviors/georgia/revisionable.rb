require 'active_support/concern'

module Georgia::Revisionable
  extend ActiveSupport::Concern

  included do
    acts_as_revisionable associations: {contents: :image, slides: {contents: :image}, ui_associations: :widgets}, dependent: :keep, on_destroy: true
    belongs_to :current_revision, class_name: ActsAsRevisionable::RevisionRecord, foreign_key: :revision_id
  end

  module ClassMethods
  end
end