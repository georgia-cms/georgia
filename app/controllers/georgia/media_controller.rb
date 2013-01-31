module Georgia
  class MediaController < Georgia::ApplicationController

    load_and_authorize_resource class: "Ckeditor::Asset"

    respond_to :js, only: :destroy

    def index
      @tags = ActsAsTaggableOn::Tag.all.sort_by{|x| x.taggings.count}.reverse
      @asset = Ckeditor::Picture.new

      if params[:tag]
        @assets = Ckeditor::Asset.tagged_with(params[:tag]).includes(:tags).page(params[:page]).per(params[:per])
      elsif params[:show] == 'orphans'
        @assets = Ckeditor::Asset.joins('LEFT JOIN taggings on ckeditor_assets.id = taggings.taggable_id').where('taggings.taggable_id IS NULL').page(params[:page]).per(params[:per])
      else
        @assets = Ckeditor::Asset.includes(:tags).page(params[:page]).per(params[:per])
      end

      @assets = @assets.order('updated_at DESC').decorate
    end

    # def create
    #   @picture = Ckeditor::Picture.create(params[:picture]).decorate
    # end

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
            render :json => [@picture.to_jq_upload].to_json
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


    # def destroy
    #   @picture = Ckeditor.picture_model.get!(params[:id]).destroy
    # end

    def destroy
      @picture = Ckeditor.picture_model.get!(params[:id]).destroy
      # render :json => true
    end

    def destroy_all
      if Ckeditor::Picture.destroy_all
        redirect_to media_index_url, notice: 'Successfully purged all images'
      else
        redirect_to media_index_url, notice: 'Oups. Something went wrong'
      end
    end

  end
end