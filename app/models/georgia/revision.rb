module Georgia
  class Revision < ActiveRecord::Base

    include PublicActivity::Common

    include Georgia::Concerns::Contentable

    enum status: [ :draft, :review, :published, :revision ]

    belongs_to :user, foreign_key: :revised_by_id

    has_one :page, foreign_key: :revision_id
    belongs_to :revisionable, polymorphic: true, touch: true

    has_many :slides, dependent: :destroy, foreign_key: :page_id
    accepts_nested_attributes_for :slides, allow_destroy: true

    has_many :ui_associations, dependent: :destroy, foreign_key: :page_id
    accepts_nested_attributes_for :ui_associations, allow_destroy: true

    has_many :widgets, through: :ui_associations

    validates :template, inclusion: {in: Georgia.templates, message: "%{value} is not a valid template" }

    delegate :visibility, to: :revisionable, prefix: false

  end
end