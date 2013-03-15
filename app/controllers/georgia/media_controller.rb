module Georgia
  class MediaController < Georgia::ApplicationController

    load_and_authorize_resource class: "Ckeditor::Asset"

    respond_to :js, only: :destroy

    def index
      @tags = ActsAsTaggableOn::Tag.all.sort_by{|x| x.taggings.count}.reverse
      @asset = Ckeditor::Picture.new

      if params[:tag]
        @assets = Ckeditor::Picture.tagged_with(params[:tag]).includes(:tags).page(params[:page]).per(params[:per])
      elsif params[:show] == 'orphans'
        @assets = Ckeditor::Picture.joins('LEFT JOIN taggings on ckeditor_assets.id = taggings.taggable_id').where('taggings.taggable_id IS NULL').page(params[:page]).per(params[:per])
      else
        @assets = Ckeditor::Picture.includes(:tags).page(params[:page]).per(params[:per])
      end

      @assets = @assets.order('updated_at DESC').decorate
    end

    def create
      @picture = Ckeditor::Picture.new(params[:picture])
      if @picture.save
        respond_to do |format|
          format.html {
            render :json => [@picture.to_jq_upload].to_json,
            :content_type => 'text/html',
            :layout => false
          }
          format.json {
            render json: {files: [@picture.to_jq_upload]}.to_json
          }
        end
      else
        render :json => [{:error => "custom_failure"}], :status => 304
      end
    end

    def update
      @picture = Ckeditor::Picture.find(params[:id])
      @picture.update_attributes(params[:asset])
      @tags = ActsAsTaggableOn::Tag.all.sort_by{|x| x.taggings.count}.reverse
      render layout: false
    end

    def destroy
      @picture = Ckeditor.picture_model.get!(params[:id]).destroy
      @tags = ActsAsTaggableOn::Tag.all.sort_by{|x| x.taggings.count}.reverse
    end

    def destroy_all
      if Ckeditor::Picture.destroy_all
        redirect_to media_index_url, notice: 'Successfully purged all images'
      else
        redirect_to media_index_url, notice: 'Oups. Something went wrong'
      end
    end

    def download_all
      @files = Ckeditor::Picture.all
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