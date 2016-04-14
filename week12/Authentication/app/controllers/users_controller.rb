class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to signin_path, notice: 'Your account was successfully created !'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @user if signed_in?
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy if signed_in?
    redirect_to signin_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end