module Georgia
  class MenusController < ApplicationController

    load_and_authorize_resource class: Menu

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
      # renders create.js.erb
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
      if ancestry_tree = params[:menu].delete(:ancestry)
        prepare_ancestry_attributes(ancestry_tree)
      end
      if @menu.update_attributes(params[:menu])
        respond_to do |format|
          format.html { redirect_to [:edit, @menu], notice: "#{@menu.title} was successfully updated." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { render :edit }
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

    def prepare_ancestry_attributes(ancestry_tree)
      merge_attributes(MenuAncestryParser.new(ancestry_tree).to_hash)
    end

    def merge_attributes(ancestry)
      ancestry.each do |id,attrs|
        params[:menu][:links_attributes][id].merge!(attrs)
      end
    end

  end
end