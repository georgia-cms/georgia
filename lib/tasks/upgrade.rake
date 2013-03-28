namespace :georgia do

  def ask question
    STDOUT.puts question
    STDIN.gets.chomp
  end

  task upgrade: :environment do
    Rake::Task['georgia:assets:rename'].execute
  end

  namespace :assets do

    task rename: :environment do

      puts "Renaming all assets...\n"

      credentials = CarrierWave::Uploader::Base.fog_credentials
      cf = CloudFiles::Connection.new(username: credentials[:rackspace_username], api_key: credentials[:rackspace_api_key])
      container = cf.container(CarrierWave::Uploader::Base.fog_directory)

      puts "Successfully logged in to Rackspace Cloud files\n"

      Ckeditor::Asset.find_each do |asset|
        asset_path = asset.data.file.path
        original_filename = asset.data.file.filename
        # Keep only what is before the random name extension of 10 digits
        regex = /(.*)\_.{10}\.[a-zA-Z]{2,6}/
        if original_filename.match(regex)
          name = original_filename.gsub(regex, '\1' )
          filename = "#{name}.#{asset.data.file.extension}"
          puts "Renamed file #{original_filename} to #{filename}\n"
        else
          filename = original_filename
          puts "Skipped renaming file #{filename}\n"
        end
        tmpfile_path = "tmp/#{filename}"
        object = container.object(asset_path)
        object.save_to_filename(tmpfile_path)
        asset.data = File.open(tmpfile_path)
        asset.save!
        puts "Succesfully moved #{filename}\n"
      end

    end

  end

end