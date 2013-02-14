require 'active_support/concern'

module Georgia::Contentable
  extend ActiveSupport::Concern

  included do
    has_many :contents, as: :contentable, dependent: :destroy, class_name: Georgia::Content
    accepts_nested_attributes_for :contents
    attr_accessible :contents_attributes
  end

  module ClassMethods
  end
end