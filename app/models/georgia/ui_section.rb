module Georgia
  class UiSection < ActiveRecord::Base
    attr_accessible :name

    has_many :ui_associations, dependent: :destroy
    has_many :widgets, through: :ui_associations
    has_many :pages, through: :ui_associations

    validates :name, presence: true
  end
end