require 'active_support/concern'

module Georgia::Previewable
  extend ActiveSupport::Concern

  included do

    def preview! attributes
      self.load_raw_attributes! attributes
    end

    private

    def load_raw_attributes! attributes
      attributes.delete(:contents).each do |content|
        self.contents << Georgia::Content.new(content, without_protection: true)
      end
      self.assign_attributes(attributes, without_protection: true)
      self
    end
  end

  module ClassMethods
  end
end