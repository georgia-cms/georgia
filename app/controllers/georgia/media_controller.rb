module Georgia
  class MediaController < ApplicationController

    def index
      authorize Ckeditor::Asset
      redirect_to action: :search
    end

    def search
      @asset = Ckeditor::Asset.new
      authorize Ckeditor::Asset
      search_conditions = Georgia::MediaSearch.new(params).definition
      @search = Ckeditor::Asset.search(search_conditions).page(params[:page])
      @assets = Ckeditor::AssetDecorator.decorate_collection(@search.records)
    end

    def create
      authorize Ckeditor::Asset
      begin
        @assets = params[:assets].map{|asset| CreateMediaAsset.new(asset).call}
        @assets = Ckeditor::AssetDecorator.decorate_collection(@assets)
      rescue => ex
        flash.now[:alert] = ex.message
      end
      render layout: false
    end

    def show
      @asset = Ckeditor::Asset.find(params[:id])
      authorize @asset
      redirect_to edit_media_path(id: params[:id])
    end

    def edit
      @asset = Ckeditor::Asset.find(params[:id])
      authorize @asset
    end

    def update
      @asset = Ckeditor::Asset.find(params[:id])
      authorize @asset
      if @asset.update_attributes(asset_params)
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
      authorize @assets
      # if can?(:destroy, Ckeditor::Asset) and @assets.destroy_all
      if @assets.destroy_all
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
      @files = Ckeditor::Asset.where(id: ids)
      authorize @files
      zip_file = Georgia::CompressFiles.new(@files).file
      send_file zip_file.path, type: "application/zip", disposition: 'attachment', filename: zip_file.filename
    end

    private

    def asset_params
      params.require(:asset).permit(:tag_list)
    end

  end
end