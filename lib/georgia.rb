require "georgia/engine"

module Georgia

  mattr_accessor :templates
  @@templates = %w(one-column sidebar-left sidebar-right)

  mattr_accessor :title
  @@title = Rails.application.class.to_s.split("::").first.downcase

  mattr_accessor :url
  @@url = "http://www.example.com"

  def self.setup
    yield self
  end
end