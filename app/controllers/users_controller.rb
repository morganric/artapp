class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:invitation]
  after_action :verify_authorized

  def index
    @users = User.all.order('created_at DESC').page params[:page]
    authorize User
  end

  def invitation
  end

  def show
    @user = User.find(params[:id])
    authorize User
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :name, :stripe_publishable_key, :stripe_secret_key)
  end

end
