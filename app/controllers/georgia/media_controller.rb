module Georgia
  class MediaController < ApplicationController

    load_and_authorize_resource class: Ckeditor::Asset
    # destroy's :id param is an Array and makes load_resource fails
    skip_load_resource only: :destroy

    def index
      redirect_to action: :search
    end

    def search
      @asset = Ckeditor::Asset.new
      @results = Georgia::Indexer.search(Ckeditor::Asset, params)
      @assets = Ckeditor::AssetDecorator.decorate_collection(@results)
    end

    def create
      @assets = []
      params[:assets].each do |asset|
        klass = asset.content_type.match(/^image/) ? Ckeditor::Picture : Ckeditor::Asset
        @assets << klass.create(data: asset)
      end
      render layout: false
    end

    def show
      redirect_to edit_media_path(id: params[:id])
    end

    def edit
      @asset = Ckeditor::Asset.find(params[:id])
    end

    def update
      @asset = Ckeditor::Asset.find(params[:id])
      if @asset.update_attributes(params[:asset])
        respond_to do |format|
          format.html { redirect_to edit_media_path(@asset), notice: "Asset was successfully updated." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to edit_media_path(@asset), alert: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end
    end

    # Destroy multiple assets
    def destroy
      @assets = Ckeditor::Asset.where(id: params[:id])
      if can?(:destroy, Ckeditor::Asset) and @assets.destroy_all
        respond_to do |format|
          format.html { redirect_to search_media_index_path, notice: "Assets were successfully deleted." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to search_media_index_path, alert: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end
    end

    # Download multiple assets as a zip file
    # TODO: We could send via AJAX with jquery.fileDownload plugin
    # We could then have a download spinner while the request is processing, even a progress bar
    def download
      ids = params[:ids].split(',')
      @files = Ckeditor::Asset.find(ids)
      t = Tempfile.new("tmp-zip-#{Time.now.to_i}")
      Zip::OutputStream.open(t.path) do |zos|
        @files.each do |file|
          filename = file.filename
          zos.put_next_entry(filename)
          tmp_file = Tempfile.new(filename)
          open(file.url) do |data|
            tmp_file.write data.read.force_encoding('UTF-8')
          end
          zos.print IO.read(tmp_file)
          tmp_file.close
        end
      end
      filename = "#{Georgia.title.try(:parameterize) || 'georgia'}_assets_#{Time.now.strftime('%Y%m%d%H%M%S')}.zip"
      t.close

      send_file t.path, type: "application/zip", disposition: 'attachment', filename: filename
    end

  end
end