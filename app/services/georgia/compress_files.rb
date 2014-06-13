module Georgia
  class CompressFiles

    def initialize files
      @files = files
      zip!
    end

    def file
      @file ||= Zipfile.new("tmp-zip-#{Time.now.to_i}")
    end

    private

    def zip!
      Zip::OutputStream.open(file.path) do |output_stream|
        @files.each do |f|
          write_to_output(output_stream, f)
        end
      end
      file.close
    end

    def write_to_output output_stream, f
      filename = f.filename
      output_stream.put_next_entry(filename)
      begin
        data = open(f.url)
      rescue Errno::ENOENT => ex
        unless data = f.data.file
          raise ex
        end
      end
      tmp_file = Tempfile.new(filename)
      tmp_file.write data.read.force_encoding('UTF-8')
      output_stream.print IO.read(tmp_file)
      tmp_file.close
    end

    class Zipfile < Tempfile

      def filename
        "#{Georgia.title.try(:parameterize) || 'georgia'}_assets_#{Time.now.strftime('%Y%m%d%H%M%S')}.zip"
      end

    end

  end
end
