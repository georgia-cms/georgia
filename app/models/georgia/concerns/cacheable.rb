require 'active_support/concern'

module Georgia
  module Concerns
    module Cacheable
      extend ActiveSupport::Concern

      included do

        def cache_key
          [self.url, self.updated_at.to_i].join('/')
        end

      end

    end
  end
end