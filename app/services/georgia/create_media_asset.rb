module Georgia
  class CreateMediaAsset

    require 'carrierwave/processing/mini_magick'

    def initialize file
      @file = file
      @asset = klass.new(data: file)
    end

    # Returns created asset
    def call
      extract_content_type
      set_file_name
      set_size
      read_dimensions
      @asset.save!
      @asset
    end

    private

    def read_dimensions
      if @asset.image? && @asset.has_dimensions?
        magick = ::MiniMagick::Image.new(@asset.data.current_path)
        @asset.width, @asset.height = magick[:width], magick[:height]
      end
    end

    def extract_content_type
      if @file.content_type == 'application/octet-stream' || @file.content_type.blank?
        content_type = MIME::Types.type_for(@file.original_filename).first
      else
        content_type = @file.content_type
      end

      @asset.data_content_type = content_type.to_s
    end

    def set_file_name
      @asset.data_file_name = @file.original_filename
    end

    def set_size
      @asset.data_file_size = @file.size
    end

    def klass
      @file.content_type.match(/^image/) ? Ckeditor::Picture : Ckeditor::Asset
    end

  end
end