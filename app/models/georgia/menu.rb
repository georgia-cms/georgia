module Georgia
  class Menu < ActiveRecord::Base

    validates :name, presence: true

    has_many :links, dependent: :destroy
    accepts_nested_attributes_for :links, allow_destroy: true

  end
end