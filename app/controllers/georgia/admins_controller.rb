module Georgia
  class AdminsController < ApplicationController

    load_and_authorize_resource class: Georgia::Admin

    def index
      @admins = AdminDecorator.decorate(Admin.order(:created_at).page(params[:page]))
    end

    def show
      redirect_to edit_admin_path(params[:id])
    end

    def new
      @admin = Admin.new
    end

    def edit
      @admin = Admin.find(params[:id])
    end

    def create
      @admin = Admin.new(params[:admin])

      if @admin.save
        redirect_to admins_url, notice: "Admin was successfully created."
      else
        render 'new'
      end
    end

    def update
      @admin = Admin.find(params[:id])
      params[:admin].delete(:password) if params[:admin][:password].blank?
      params[:admin].delete(:password_confirmation) if params[:admin][:password].blank? and params[:admin][:password_confirmation].blank?
      if @admin.update_attributes(params[:admin])
        redirect_to admins_url, notice: "Admin was successfully updated."
      else
        render 'edit'
      end
    end

    def destroy
      @admin = Admin.find(params[:id])
      @admin.destroy
      redirect_to admins_url, notice: "Admin was successfully deleted."
    end



  end

end