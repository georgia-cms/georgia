module Georgia
  class Menu < ActiveRecord::Base

    attr_accessible :name

    validates :name, presence: true

    has_many :links, dependent: :destroy

  end
end