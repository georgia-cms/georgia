require 'active_support/concern'

module Georgia::Orderable
  extend ActiveSupport::Concern

  included do

    acts_as_list
    attr_accessible :position

    scope :ordered, order(:position)

  end

  module ClassMethods
  end
end