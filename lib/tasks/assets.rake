namespace :assets do

  desc "Move assets to new folder structure with asset's id in folder path"
  task rename: :environment do

    @connection = CloudFilesConnection.new

    Ckeditor::Picture.find_each do |asset|
      TransferablePicture.new(asset, @connection.container).process
    end
  end

  desc "Download all assets"
  task download: :environment do

    puts "Downloading all assets...\n"

    credentials = CarrierWave::Uploader::Base.fog_credentials
    cf = CloudFiles::Connection.new(username: credentials[:rackspace_username], api_key: credentials[:rackspace_api_key])
    container = cf.container(CarrierWave::Uploader::Base.fog_directory)

    puts "Successfully connected to Rackspace Cloud Files\n"

    tmp_path = "/tmp/backup-#{timestamp}"
    system "mkdir -p #{tmp_path}"
    objects = container.objects
    objects.each do |path|
      filename = path.gsub(/.*\//, '')
      tmp_filename = "#{tmp_path}/#{filename}"
      begin
        object = container.object(path)
        object.save_to_filename(tmp_filename)
      rescue Exception
        puts "#{filename} failed. Retry"
        retry
      end
      puts "#{filename} saved."
    end

    puts "All files have been downloaded.\n"

    puts "Creating zipped archive.\n"
    tar_filename = "#{tmp_path}.tar.gz"
    system "tar -czvf #{tar_filename} #{tmp_path}"
    puts "File accessible at #{tar_filename}"
    puts "Finished."

  end

  desc "Copying all assets to a new container"
  task copy: :environment do

    puts "Copying all assets to a new container"

    credentials = CarrierWave::Uploader::Base.fog_credentials
    cf = CloudFiles::Connection.new(username: credentials[:rackspace_username], api_key: credentials[:rackspace_api_key])
    container_name = CarrierWave::Uploader::Base.fog_directory
    container_from = cf.container(container_name)

    puts "Successfully connected to Rackspace Cloud Files\n"

    container_to = cf.create_container("#{container_name}-copy-#{timestamp}")

    puts "#{container_name}-copy-#{timestamp} container created\n"

    container_from.objects.each do |path|
      retries = 0
      puts "Saving #{path}"
      begin
        object = container_from.object(path)
        copy = container_to.create_object(path)
        copy.write(object.data)
      rescue Exception
        retries = retries + 1
        unless retries > 5
          puts "#{path} failed. Retry"
          retry
        else
          puts "#{path} failed."
        end
      end
    end

    puts "All assets have been copied to #{container_name}-copy-#{timestamp}"

    container_to.refresh

  end

  def ask question
    STDOUT.puts question
    STDIN.gets.chomp
  end

  def timestamp
    @timestamp ||= Time.now.strftime('%Y%m%d%H%M')
  end

end