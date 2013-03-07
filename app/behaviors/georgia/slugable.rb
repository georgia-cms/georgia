require 'active_support/concern'

module Georgia::Slugable
  extend ActiveSupport::Concern

  included do

    attr_accessible :slug

    validates :slug, format: {with: /^[a-zA-Z0-9_-]+$/, message: 'can only consist of letters, numbers, dash (-) and underscore (_)'}, uniqueness: {scope: :ancestry, message: 'has already been taken'}

    before_validation :sanitize_slug

    protected

    def sanitize_slug
      self.slug ||= ''
      self.slug.gsub!(/^\/*/, '').gsub!(/\/*$/, '')
    end

  end

  module ClassMethods
  end
end