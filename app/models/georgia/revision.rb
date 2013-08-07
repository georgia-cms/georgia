module Georgia
  class Revision < ActiveRecord::Base

    include Georgia::Concerns::Contentable
    include Georgia::Concerns::Templatable
    include Georgia::Concerns::Previewable
    include Georgia::Concerns::Statable

    belongs_to :revisionable, polymorphic: true

    has_many :slides, dependent: :destroy, foreign_key: :page_id
    accepts_nested_attributes_for :slides
    attr_accessible :slides_attributes

    has_many :ui_associations, dependent: :destroy, foreign_key: :page_id
    has_many :widgets, through: :ui_associations

  end
end