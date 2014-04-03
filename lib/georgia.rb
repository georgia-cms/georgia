require "georgia/version"
require "georgia/paths"
require "georgia/engine"
require "georgia/indexer"
require "georgia/uploader/adapter"

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

  mattr_accessor :storage
  @@storage = :fog

  def self.setup
    yield self
    # TODO: Add callbacks after_setup. We can only include indexer methods once indexer is set.
    ActsAsTaggableOn::Tag.send(:include, Georgia::Indexer::Adapter)
  end

  class << self
    alias :header :navigation

    def header= value
      ActiveSupport::Deprecation.warn("config.header is deprecated, use config.navigation instead.", caller)
    end
  end

end