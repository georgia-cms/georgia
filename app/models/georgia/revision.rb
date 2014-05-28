module Georgia
  class Revision < ActiveRecord::Base

    include Georgia::Concerns::Contentable

    enum status: [ :draft, :review, :published, :revision ]

    has_one :page, foreign_key: :revision_id
    belongs_to :revisionable, polymorphic: true, touch: true

    has_many :slides, dependent: :destroy, foreign_key: :page_id
    accepts_nested_attributes_for :slides, allow_destroy: true

    has_many :ui_associations, dependent: :destroy, foreign_key: :page_id
    accepts_nested_attributes_for :ui_associations, allow_destroy: true

    has_many :widgets, through: :ui_associations

    validates :template, inclusion: {in: Georgia.templates, message: "%{value} is not a valid template" }

    def review
      update(status: :review)
    end
    def approve
      update(status: :published)
      set_as_current
    end
    def decline
      update(status: :draft)
    end
    def store
      update(status: :revision)
    end
    def unpublish
      update(status: :draft)
    end
    def restore
      update(status: :published)
      set_as_current
    end
    def set_as_current
      revisionable.current_revision.store if revisionable.current_revision
      revisionable.update(revision_id: self.id)
    end

  end
end