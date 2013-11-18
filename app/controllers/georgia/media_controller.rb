module Georgia
  class MediaController < ApplicationController

    # load_and_authorize_resource class: Ckeditor::Asset

    def index
      redirect_to action: :search
    end

    def search
      @asset = Ckeditor::Asset.new
      session[:search_params] = params
      @search = Ckeditor::Asset.search do
        fulltext params[:query] do
          fields(:filename, :tags)
        end
        with(:extension, params[:e]) unless params[:e].blank?
        with(:tags).any_of(params[:tg]) unless params[:tg].blank?
        order_by (params[:o] || :updated_at), (params[:dir] || :desc)
        paginate(page: params[:page], per_page: (params[:per] || 8))
      end
      @assets = Ckeditor::AssetDecorator.decorate_collection(@search.results)
    end

    def create
      @assets = []
      params[:assets].each do |asset|
        klass = asset.content_type.match(/^image/) ? Ckeditor::Picture : Ckeditor::Asset
        @assets << klass.create(data: asset)
      end
      render layout: false
    end

    def update
      @asset = Ckeditor::Asset.find(params[:id])
      @asset.update_attributes(params[:asset])
      render nothing: true
    end

    # Destroy multiple assets
    def destroy
      @pages = Ckeditor::Asset.where(id: params[:id])
      if @pages.destroy_all
        respond_to do |format|
          format.html { redirect_to :back, notice: "Assets were successfully deleted." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to :back, alert: "Oups. Something went wrong." }
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