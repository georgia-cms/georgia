require 'active_support/concern'
require 'georgia/uploader/storage/cloudinary'
require 'georgia/uploader/storage/fog'
require 'georgia/uploader/storage/file'

module Georgia
  module Uploader
    module Adapter
      extend ActiveSupport::Concern

      included do
        case Georgia.storage
        when :cloudinary
          include(Georgia::Uploader::Storage::Cloudinary)
        when :fog
          include(Georgia::Uploader::Storage::Fog)
        when :file
          include(Georgia::Uploader::Storage::File)
        else
          include(Georgia::Uploader::Storage::File)
        end
      end

    end
  end
end