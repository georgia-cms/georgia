namespace :assets do

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

  def timestamp
    @timestamp ||= Time.now.strftime('%Y%m%d%H%M')
  end

end