module Georgia
  class WidgetsController < ApplicationController

    load_and_authorize_resource class: Georgia::Widget

    def index
      @widgets = Widget.order(:created_at).page(params[:page]).in_groups_of(4, false)
    end

    def show
      redirect_to edit_widget_path(params[:id])
    end

    def new
      @widget = Widget.new
    end

    def edit
      @widget = Widget.find(params[:id])
    end

    def create
      @widget = Widget.new(params[:widget])

      if @widget.save
        redirect_to widgets_url, notice: "Widget was successfully created."
      else
        render 'new'
      end
    end

    def update
      @widget = Widget.find(params[:id])
      if @widget.update_attributes(params[:widget])
        respond_to do |format|
          format.html { redirect_to widgets_url, notice: "Widget was successfully updated." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { render :index, alert: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end
    end

    def destroy
      @widget = Widget.find(params[:id])
      @widget.destroy
      redirect_to widgets_url, notice: "Widget was successfully deleted."
    end

  end

end