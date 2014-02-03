require "georgia/version"
require "georgia/paths"
require "georgia/engine"
require "georgia/assets"
require "georgia/indexer"

module Georgia

  mattr_accessor :templates
  @@templates = %w(default one-column sidebar-left sidebar-right)

  mattr_accessor :title
  @@title = "Georgia"

  mattr_accessor :url
  @@url = "http://www.example.com"

  mattr_accessor :navigation
  @@navigation = %w(dashboard pages media navigation widgets)

  mattr_accessor :indexer
  @@indexer = :tire

  def self.setup
    yield self
  end

  class << self
    alias :header :navigation

    def header= value
      ActiveSupport::Deprecation.warn("config.header is deprecated, use config.navigation instead.", caller)
    end
  end

end