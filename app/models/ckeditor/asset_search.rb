require 'active_support/concern'
module Ckeditor
  module AssetSearch
    extend ActiveSupport::Concern

    included do
      def as_indexed_json options={}
        self.as_json(
          only: [:id, :data_file_name, :updated_at],
          methods: [:tag_list, :image?]
        )
      end
    end
  end
end