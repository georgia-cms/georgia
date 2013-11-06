module Georgia
  class Menu < ActiveRecord::Base

    attr_accessible :name

    validates :name, presence: true

    has_many :links, dependent: :destroy
    accepts_nested_attributes_for :links
    attr_accessible :links_attributes

  end
end