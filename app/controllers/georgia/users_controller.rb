module Georgia
  class UsersController < ApplicationController

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
      begin
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound => ex
        redirect_to users_url, alert: "This user doesn't exist anymore."
      end
    end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to users_url, notice: "User was successfully created."
      else
        render :new
      end
    end

    def update
      @user = User.find(params[:id])
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      if @user.update(user_params)
        redirect_to users_url, notice: "User was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to users_url, notice: "User was successfully deleted."
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :role_ids, :receives_notifications)
    end

  end

end