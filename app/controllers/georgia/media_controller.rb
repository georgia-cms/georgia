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
      if @asset.update_attributes(sanitized_asset_params)
        render_success("Asset was successfully updated.")
      else
        render_error
      end
    end

    # Destroy multiple assets
    def destroy
      @assets = Ckeditor::Asset.where(id: params[:id])
      authorize @assets
      if @assets.destroy_all
        render_success("Assets were successfully deleted.")
      else
        render_error
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

    def sanitized_asset_params
      ParseJsonTags.new(asset_params).call
    end

    def render_success success_message
      @status_message = success_message
      @status = :notice
      respond_to do |format|
        format.html { redirect_to :back, notice: @status_message }
        format.js   { render layout: false }
        format.json { render json: { ids: @assets.map(&:id), message: @status_message, status: @status } }
      end
    end

    def render_error error_message="Oups. Something went wrong."
      @status_message = error_message
      @status = :alert
      respond_to do |format|
        format.html { redirect_to :back, alert: @status_message }
        format.js   { render layout: false }
        format.json { render json: { message: @status_message, status: @status } }
      end
    end

  end
end