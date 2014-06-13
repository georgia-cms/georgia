require "georgia/version"
require "georgia/paths"
require "georgia/engine"
require "georgia/uploader/adapter"
require "georgia/permissions"

module Georgia

  mattr_accessor :templates
  @@templates = %w(default one-column sidebar-left sidebar-right)

  mattr_accessor :title
  @@title = "Georgia"

  mattr_accessor :url
  @@url = "http://www.example.com"

  mattr_accessor :navigation
  @@navigation = %w(dashboard pages media navigation widgets)

  mattr_accessor :storage
  @@storage = :file

  mattr_accessor :permissions
  @@permissions = ActiveSupport::HashWithIndifferentAccess.new(Georgia::Permissions::DEFAULT_PERMISSIONS)

  mattr_accessor :roles
  @@roles = %w(admin editor contributor guest)

  class << self
    alias :header :navigation

    def setup
      yield self
      verify_data_integrity
    end

    def verify_data_integrity
      Georgia.roles.each do |role_name|
        Georgia::Role.where(name: role_name).first_or_create
      end
    end

    def header= value
      ActiveSupport::Deprecation.warn("config.header is deprecated, use config.navigation instead.", caller)
    end
    def indexer= value
      ActiveSupport::Deprecation.warn("config.indexer is deprecated, we jumped on the ElasticSearch train.", caller)
    end
  end

end