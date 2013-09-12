class CloudFilesConnection

  attr_accessor :connection

  def initialize
    @connection = CloudFiles::Connection.new(username: credentials[:rackspace_username], api_key: credentials[:rackspace_api_key])
    puts "Successfully logged in to Rackspace Cloud files\n"
  end

  def credentials
    @credentials ||= CarrierWave::Uploader::Base.fog_credentials
  end

  def container
    @container ||= connection.container(CarrierWave::Uploader::Base.fog_directory)
  end

  def asset_host
    @asset_host ||= CarrierWave::Uploader::Base.asset_host
  end

end