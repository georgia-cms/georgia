module Georgia
  class MenusController < Georgia::ApplicationController

    load_and_authorize_resource class: 'Georgia::Menu'

    helper_method :sort_column, :sort_direction

    def index
      @menus = Georgia::Menu.order(sort_column + ' ' + sort_direction).page(params[:page])
    end

    def destroy
      @menu = Georgia::Menu.find(params[:id])
      @menu.destroy

      redirect_to menus_url
    end

    def new
      @menu = Georgia::Menu.new
    end

    def create
      @menu = Georgia::Menu.new(params[:menu])

      if @menu.save
        redirect_to [:edit, @menu], notice: "#{@menu.name} was successfully sent."
      else
        render action: "new"
      end
    end

    def show
      redirect_to edit_menu_path(params[:id])
    end

    def edit
      @menu = Georgia::Menu.find(params[:id])
      @pages = Georgia::Page.scoped.decorate
      @link = Georgia::Link.new
      @link.menu = @menu
    end

    private

    def sort_column
      Georgia::Menu.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
  end
end