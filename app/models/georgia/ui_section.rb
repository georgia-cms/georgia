module Georgia
  class UiSection < ActiveRecord::Base
    attr_accessible :name if needs_attr_accessible?

    has_many :ui_associations, dependent: :destroy
    has_many :widgets, through: :ui_associations
    has_many :revisions, through: :ui_associations
    has_many :pages, through: :revisions

    validates :name, presence: true, uniqueness: true
  end
end