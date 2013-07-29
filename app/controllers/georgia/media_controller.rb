module Georgia
  class MediaController < Georgia::ApplicationController

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
        paginate(page: params[:page], per_page: (params[:per] || 25))
      end
      @assets = Ckeditor::AssetDecorator.decorate_collection(@search.results)
    end

    def create
      p_attr = params[:asset]
      p_attr[:data] = params[:asset][:data].first if params[:asset][:data].is_a? Array

      if p_attr[:data].content_type.match(/^image/)
        @asset = Ckeditor::Picture.new(params[:asset])
      else
        @asset = Ckeditor::Asset.new(params[:asset])
      end

      if @asset.save
        respond_to do |format|
          format.html {
            render json: [@asset.to_jq_upload].to_json, content_type: 'text/html', layout: false
          }
          format.json {
            render json: {files: [@asset.to_jq_upload]}.to_json
          }
        end
      else
        render :json => [{:error => "custom_failure"}], :status => 304
      end
    end

    def update
      @asset = Ckeditor::Asset.find(params[:id])
      @asset.update_attributes(params[:asset])
      @tags = ActsAsTaggableOn::Tag.all.sort_by{|x| x.taggings.count}.reverse
      render layout: false
    end

    def destroy
      @asset = Ckeditor::Asset.find(params[:id]).destroy
      @tags = ActsAsTaggableOn::Tag.all.sort_by{|x| x.taggings.count}.reverse
    end

    def destroy_all
      if Ckeditor::Asset.destroy_all
        redirect_to media_index_url, notice: 'Successfully purged all images'
      else
        redirect_to media_index_url, notice: 'Oups. Something went wrong'
      end
    end

    def download_all
      @files = Ckeditor::Asset.all
      t = Tempfile.new("tmp-zip-#{Time.now}")
      Zip::ZipOutputStream.open(t.path) do |zos|
        @files.each do |file|
          filename = file.data.file.filename
          zos.put_next_entry(filename)
          tmp_file = Tempfile.new(filename)
          open(file.data.url) do |data|
            tmp_file.write data.read.force_encoding('UTF-8')
          end
          zos.print IO.read(tmp_file)
          tmp_file.close
        end
      end
      filename = "#{Georgia.title.try(:parameterize)}_assets_#{Time.now.strftime('%Y%m%d%H%M')}.zip"
      t.close

      send_file t.path, type: "application/zip", disposition: 'attachment', filename: filename
    end

  end
end