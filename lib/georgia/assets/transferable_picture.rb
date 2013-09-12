class TransferablePicture

  attr_accessor :asset, :container

  def initialize asset, container
    @asset = asset
    @container = container
  end

  def process
    copy_file
    recreate_versions!
  end

  private

  def asset_host
    @asset_host ||= CarrierWave::Uploader::Base.asset_host
  end

  def filename
    @filename ||= asset.data_file_name
  end

  def old_path
    @old_path ||= 'system/ckeditor_assets/pictures/' + filename
  end

  def new_path
    @new_path ||= "assets/#{asset.id}/" + filename
  end

  def copy_file
    if container.object_exists?(old_path)
        if !container.object_exists?(new_path)
        container.object(old_path).copy(name: new_path)
        # asset.remote_data_url = asset_host + '/' + new_path
        puts "#{filename} copied from #{old_path} to #{new_path}"
      else
        puts "#{new_path} destination already exists"
      end
    else
      puts "#{old_path} does not exists"
    end
  end

  def recreate_versions!
    puts "#{filename} versions recreated" if asset.data.recreate_versions!
  end

end