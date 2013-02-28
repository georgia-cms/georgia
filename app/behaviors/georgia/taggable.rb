require 'active_support/concern'

module Georgia::Taggable
  extend ActiveSupport::Concern

  included do

    acts_as_taggable_on :tags
    attr_accessible :tag_list

  end

  module ClassMethods
  end
end