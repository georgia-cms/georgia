module ActsAsRevisionable
  class RevisionRecord < ActiveRecord::Base
    belongs_to :revisionable, polymorphic: true
  end
end