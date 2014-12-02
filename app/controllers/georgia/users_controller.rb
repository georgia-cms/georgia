module Georgia
  class UsersController < ApplicationController

    def index
      authorize Georgia::User
      @users = User.order(:created_at).page(params[:page])
    end

    def show
      @user = User.find(params[:id])
      authorize @user
      redirect_to [:edit, @user]
    end

    def new
      @user = User.new
      authorize @user
    end

    def edit
      begin
        @user = User.find(params[:id])
        authorize @user
      rescue ActiveRecord::RecordNotFound => ex
        redirect_to users_path, alert: "This user doesn't exist anymore."
      end
    end

    def create
      @user = User.new(user_params)
      authorize @user

      if @user.save
        redirect_to users_path, notice: "User was successfully created."
      else
        render :new
      end
    end

    def update
      @user = User.find(params[:id])
      authorize @user
      params[:user].delete(:password) if params[:user][:password].blank?
      params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
      if @user.update(user_params)
        redirect_to users_path, notice: "User was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      authorize @user
      @user.destroy
      redirect_to users_path, notice: "User was successfully deleted."
    end

    def permissions
      authorize Georgia::User
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :receives_notifications, role_ids: [])
    end

  end

end