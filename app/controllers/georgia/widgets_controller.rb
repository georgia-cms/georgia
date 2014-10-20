module Georgia
  class WidgetsController < ApplicationController

    load_and_authorize_resource class: Georgia::Widget

    def index
      @widgets = Widget.order(:created_at).includes(:contents).page(params[:page]).in_groups_of(4, false)
      @widget = Widget.new
      @widget.contents.build(locale: current_locale)
    end

    def edit
      @widget = Widget.find(params[:id])
    end

    def create
      @widget = Widget.new(params[:widget])

      if @widget.save
        respond_to do |format|
          format.html { redirect_to widgets_url, notice: "Widget was successfully updated." }
          format.js { render layout: false }
        end
      else
        respond_to do |format|
          format.html { redirect_to widgets_url, alert: "Oups. Something went wrong." }
          format.js { render layout: false }
        end
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
      if @widget.destroy
        respond_to do |format|
          format.html { redirect_to widgets_url, notice: "Widget was successfully deleted." }
          format.js { head :ok }
        end
      else
        respond_to do |format|
          format.html { redirect_to widgets_url, alert: "Oups. Something went wrong." }
          format.js { head :internal_server_error }
        end
      end


    end

  end

end