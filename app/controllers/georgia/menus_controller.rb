module Georgia
  class MenusController < ApplicationController

    def index
      @menus = Menu.scoped.page(params[:page])
    end

    def new
      @menu = Menu.new
    end

    def create
      @menu = Menu.new(params[:menu])
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
      redirect_to edit_menu_path(params[:id])
    end

    def edit
      @menu = Menu.find(params[:id])
      @links = @menu.links.roots
    end

    def update
      @menu = Menu.find(params[:id])
      update_links_attributes(params[:menu].delete(:ancestry))
      update_links_menu_id
      if @menu.update_attributes(params[:menu])
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

  end
end