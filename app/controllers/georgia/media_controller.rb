module Georgia
  class MediaController < ApplicationController

    load_and_authorize_resource class: Ckeditor::Asset

    respond_to :js, only: :destroy

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
        facet :tags, :extension#, extra: [:any, :none]
        facet(:size, zeros: params[:s].blank?){Ckeditor::Asset::SIZE_RANGE.each{|k,v| row(k){with(:size, v)}}}
        with(:extension, params[:e]) unless params[:e].blank?
        with(:tags).any_of(params[:tg]) unless params[:tg].blank?
        Ckeditor::Asset::SIZE_RANGE.each{|k,v| with(:size, v) if params[:s] == k }
        order_by (params[:o] || :updated_at), (params[:dir] || :desc)
        paginate(page: params[:page], per_page: (params[:per] || 8))
      end
      @assets = Ckeditor::AssetDecorator.decorate_collection(@search.results)
    end

    def create
      @assets = []
      if params[:assets] and params[:assets].any?
        params[:assets].each do |asset|
          if asset.content_type.match(/^image/)
            @asset = Ckeditor::Picture.new(data: asset)
          else
            @asset = Ckeditor::Asset.new(data: asset)
          end
          if @asset.save
            @assets << @asset.decorate
          end
        end
      end
    end

    def update
      @asset = Ckeditor::Asset.find(params[:id])
      @asset.update_attributes(params[:asset])
      render nothing: true
    end

    # Destroy multiple assets
    def destroy
      if Ckeditor::Asset.destroy(params[:ids])
        head :ok
      else
        head :internal_server_error
      end
    end

    # Download multiple assets as a zip file
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