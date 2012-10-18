module Georgia
  class MediaController < Georgia::ApplicationController

    load_and_authorize_resource class: "Ckeditor::Asset"

    def index
      @assets = Ckeditor::Asset.all
      @asset = Ckeditor::Picture.new
    end

    def create
      @picture = Ckeditor::Picture.new(params[:picture])
      if @picture.save
        redirect_to media_index_path, notice: "Picture successfully added."
      else
        redirect_to media_index_path, notice: 'Something went wrong'
      end
    end

    def destroy
      @picture = Ckeditor.picture_model.get!(params[:id])
      if @picture.destroy
        redirect_to media_index_path, notice: "Picture successfully deleted."
      else
        redirect_to media_index_path, notice: 'Something went wrong'
      end
    end

  end
end