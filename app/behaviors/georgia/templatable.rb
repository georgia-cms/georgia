require 'active_support/concern'

module Georgia::Templatable
  extend ActiveSupport::Concern

  included do

    attr_accessible :template

    validates :template, inclusion: {in: Georgia.templates, message: "%{value} is not a valid template" }

  end

  module ClassMethods
  end
end