module Georgia
  class UsersController < ApplicationController

    load_and_authorize_resource class: Georgia::User

    def index
      @users = User.order(:created_at).page(params[:page])
    end

    def show
      redirect_to edit_user_path(params[:id])
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(params[:user])

      if @user.save
        redirect_to users_url, notice: "User was successfully created."
      else
        render 'new'
      end
    end

    def update
      @user = User.find(params[:id])
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      if @user.update_attributes(params[:user])
        redirect_to users_url, notice: "User was successfully updated."
      else
        render 'edit'
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_url, notice: "User was successfully deleted."
    end

  end

end