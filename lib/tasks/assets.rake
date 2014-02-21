namespace :assets do

  desc "Move assets to new folder structure with asset's id in folder path"
  task rename: :environment do

    @connection = CloudFilesConnection.new

    Ckeditor::Picture.find_each do |asset|
      retries = 0
      begin
        TransferablePicture.new(asset, @connection.container).process
      rescue => e
        puts e.message
        retries = retries + 1
        retry unless retries > 5
      end
    end
  end

end