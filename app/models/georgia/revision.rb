module Georgia
  class Revision < ActiveRecord::Base

    include Georgia::Concerns::Contentable
    include Georgia::Concerns::Templatable
    include Georgia::Concerns::Previewable
    include Georgia::Concerns::Statable

    has_one :page, foreign_key: :revision_id
    belongs_to :revisionable, polymorphic: true, touch: true

    has_many :slides, dependent: :destroy, foreign_key: :page_id
    accepts_nested_attributes_for :slides, allow_destroy: true
    attr_accessible :slides_attributes

    has_many :ui_associations, dependent: :destroy, foreign_key: :page_id
    accepts_nested_attributes_for :ui_associations, allow_destroy: true
    attr_accessible :ui_associations_attributes

    has_many :widgets, through: :ui_associations

  end
end