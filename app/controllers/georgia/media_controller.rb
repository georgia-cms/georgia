module Georgia
  class MediaController < Georgia::ApplicationController

    load_and_authorize_resource class: "Ckeditor::Asset"

    def index
      @assets = Ckeditor::Asset.all
      @asset = Ckeditor::Picture.new
    end

    def create
      @picture = Ckeditor::Picture.create(params[:picture])
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