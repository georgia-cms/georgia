require 'active_support/concern'

module Georgia
  module Uploader
    module Storage
      module Cloudinary
        extend ActiveSupport::Concern

        included do
          'georgia/uploader/storage/cloudinary'
          include ::Cloudinary::CarrierWave
        end

        def public_id
          model.short_name
        end

      end
    end
  end
end