module Georgia
  class MediaController < Georgia::ApplicationController

    load_and_authorize_resource class: "Ckeditor::Asset"

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

      @assets = AssetDecorator.decorate(@assets)
    end

    def create
      @picture = AssetDecorator.decorate(Ckeditor::Picture.create(params[:picture]))
    end

    def update
      @picture = Ckeditor::Picture.find(params[:id])
      @picture.update_attributes(params[:picture])
      @tags = ActsAsTaggableOn::Tag.all.sort_by{|x| x.taggings.count}.reverse
      render layout: false
    end

    def destroy
      @picture = Ckeditor.picture_model.get!(params[:id]).destroy
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