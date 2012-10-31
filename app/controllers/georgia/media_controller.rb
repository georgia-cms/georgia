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

  end
end