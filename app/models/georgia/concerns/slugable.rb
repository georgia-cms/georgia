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

        protected

        def sanitize_slug
          self.slug ||= ''
          self.slug.gsub!(/^\/*/, '').gsub!(/\/*$/, '')
        end

        def update_url
          if slug_changed?
            self.update_column(:url, '/' + self.ancestry_url)
            if !self.new_record? and self.has_children?
              self.descendants.each do |descendant|
                descendant.update_column(:url, '/' + descendant.ancestry_url)
              end
            end
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