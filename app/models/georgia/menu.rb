module Georgia
  class Menu < ActiveRecord::Base

    if needs_attr_accessible?
      attr_accessible :name
    end

    validates :name, presence: true

    has_many :links, dependent: :destroy
    accepts_nested_attributes_for :links, allow_destroy: true
    attr_accessible :links_attributes if needs_attr_accessible?

  end
end