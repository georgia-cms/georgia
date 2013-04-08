module Georgia
  class Menu < ActiveRecord::Base

    attr_accessible :name

    has_many :links, dependent: :destroy

  end
end