require 'active_support/concern'

module Georgia
  module Concerns
    module Slugable
      extend ActiveSupport::Concern

      included do

        attr_accessible :slug, :url

        validates :slug, format: {with: /^[a-zA-Z0-9_-]+$/, message: 'can only consist of letters, numbers, dash (-) and underscore (_)'}, uniqueness: {scope: :ancestry, message: 'has already been taken'}

        before_validation :sanitize_slug
        after_create :update_url
        before_update :update_url

        protected

        def sanitize_slug
          self.slug ||= ''
          self.slug.gsub!(/^\/*/, '').gsub!(/\/*$/, '')
        end

        # FIXME: should only be apply if slug_changed? or one of the ancestors' slug changed
        def update_url
          self.update_column(:url, ('/' + ancestry_url))
        end

        private

        def ancestry_url
          (ancestors + [self]).map(&:slug).join('/')
        end

      end

      module ClassMethods
      end
    end
  end
end