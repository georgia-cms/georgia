# This file was added by Georgia for you to customize a storage location

# Follow example configs from CarrierWave README file
# Here are some of their examples for Amazon, Rackspace and Google Storage

# AMAZON S3
# https://github.com/carrierwaveuploader/carrierwave#using-amazon-s3
# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     :provider               => 'AWS',                        # required
#     :aws_access_key_id      => 'xxx',                        # required
#     :aws_secret_access_key  => 'yyy',                        # required
#     :region                 => 'eu-west-1',                  # optional, defaults to 'us-east-1'
#     :host                   => 's3.example.com',             # optional, defaults to nil
#     :endpoint               => 'https://s3.example.com:8080' # optional, defaults to nil
#   }
#   config.fog_directory  = 'name_of_directory'                     # required
#   config.fog_public     = false                                   # optional, defaults to true
#   config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
# end

# RACKSPACE
# https://github.com/carrierwaveuploader/carrierwave#using-rackspace-cloud-files
# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     :provider           => 'Rackspace',
#     :rackspace_username => 'xxxxxx',
#     :rackspace_api_key  => 'yyyyyy',
#     :rackspace_region   => :ord                # optional, defaults to :dfw
#   }
#   config.fog_directory = 'name_of_directory'
#   config.asset_host = "http://c000000.cdn.rackspacecloud.com"
# end

# GOOGLE STORAGE
# https://github.com/carrierwaveuploader/carrierwave#using-google-storage-for-developers
# CarrierWave.configure do |config|
#   config.fog_credentials = {
#     :provider                         => 'Google',
#     :google_storage_access_key_id     => 'xxxxxx',
#     :google_storage_secret_access_key => 'yyyyyy'
#   }
#   config.fog_directory = 'name_of_directory'
# end