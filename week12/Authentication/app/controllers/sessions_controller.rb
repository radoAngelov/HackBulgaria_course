class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user and @user.authenticate(params[:session][:password])
      sign_in @user
      remember @user if params[:remember_me] == "1"
      render :show
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render :new
    end
  end

  def show
    signed_in?
  end

  def destroy
    sign_out if signed_in?
    redirect_to signin_path
  end

  private

  def session_params
    params.permit(:remember_me)
    params.require(:session).permit(:email, :password)
  end
end
