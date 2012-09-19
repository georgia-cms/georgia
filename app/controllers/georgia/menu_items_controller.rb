module Georgia
  class MenuItemsController < ApplicationController

    def activate
      if MenuItem.activate(params[:menu_item])
        flash[:notice] = "Your Navigation Menu was successfully updated."
      end
      render :update, layout: false
    end

    def deactivate
      if MenuItem.deactivate(params[:menu_item])
        flash[:notice] = "Your Navigation Menu was successfully updated."
      end
      render :update, layout: false
    end

  end
end