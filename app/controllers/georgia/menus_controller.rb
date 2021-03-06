module Georgia
  class MenusController < ApplicationController

    def index
      @menus = Menu.all
      authorize @menus
    end

    def new
      @menu = Menu.new
      authorize @menu
    end

    def create
      @menu = Menu.new(menu_params)
      authorize @menu
      if @menu.save
        respond_to do |format|
          format.html { redirect_to [:edit, @menu], notice: "#{@menu.title} was successfully created." }
          format.js { render layout: false }
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.js { render layout: false }
        end
      end
    end

    def show
      @menu = Menu.find(params[:id])
      authorize @menu
      redirect_to [:edit, @menu]
    end

    def edit
      @menu = Menu.find(params[:id])
      authorize @menu
      @links = @menu.links.roots
    end

    def update
      @menu = Menu.find(params[:id])
      authorize @menu
      update_links_attributes(params[:menu].delete(:ancestry))
      update_links_menu_id
      if @menu.update(menu_params)
        respond_to do |format|
          format.html { redirect_to [:edit, @menu], notice: "#{@menu.title} was successfully updated." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { render :edit, alert: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end
    end

    def destroy
      @menu = Menu.find(params[:id])
      authorize @menu
      @menu.destroy

      redirect_to menus_url
    end

    private

    def update_links_attributes ancestry_tree
      return unless ancestry_tree
      ancestry_attributes(ancestry_tree).each do |k,v|
        params[:menu][:links_attributes][k].merge!(v)
      end
    end

    def update_links_menu_id
      Link.where(id: params[:menu][:links_attributes].keys).update_all(menu_id: params[:id])
    end

    def ancestry_attributes(ancestry_tree)
      MenuAncestryParser.new(ancestry_tree).to_hash
    end

    def menu_params
      params.require(:menu).permit(:name, :ancestry, links_attributes: [:id, :_destroy, :position, :parent_id, contents_attributes: [:id, :title, :text, :locale]])
    end

  end
end