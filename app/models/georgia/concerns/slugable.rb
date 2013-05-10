require 'active_support/concern'

module Georgia
  module Concerns
    module Slugable
      extend ActiveSupport::Concern

      included do

        attr_accessible :slug, :url

        validates :slug, format: {with: /^[a-zA-Z0-9_-]+$/, message: 'can only consist of letters, numbers, dash (-) and underscore (_)'}, uniqueness: {scope: :ancestry, message: 'has already been taken'}

        before_validation :sanitize_slug
        after_save :update_url

        def set_url
          self.update_column(:url, '/' + self.ancestry_url)
        end

        protected

        def sanitize_slug
          self.slug ||= ''
          self.slug.gsub!(/^\/*/, '').gsub!(/\/*$/, '')
        end

        def update_url
          if slug_changed?
            self.set_url
            self.descendants.each(&:set_url) if !self.new_record? and self.has_children?
          end
        end

        def ancestry_url
          (ancestors + [self]).map(&:slug).join('/')
        end

      end

      module ClassMethods
      end
    end
  end
end