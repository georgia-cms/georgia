require 'active_support/concern'

module Georgia
  module Concerns
    module Slugable
      extend ActiveSupport::Concern

      included do

        attr_accessible :slug

        validates :slug, format: {with: /^[a-zA-Z0-9_-]+$/, message: 'can only consist of letters, numbers, dash (-) and underscore (_)'}, uniqueness: {scope: :ancestry, message: 'has already been taken'}

        before_validation :sanitize_slug

        def url options={}
          '/' + localized_slug(options) + ancestry_url
        end

        protected

        def localized_slug options={}
          locale = options[:locale] || I18n.locale.to_s
          (I18n.available_locales.length > 1) ? "#{locale}/" : ''
        end

        def ancestry_url
          (ancestors + [self]).map(&:slug).join('/')
        end

        def sanitize_slug
          self.slug ||= ''
          self.slug.gsub!(/^\/*/, '').gsub!(/\/*$/, '')
        end

      end

      module ClassMethods
      end
    end
  end
end