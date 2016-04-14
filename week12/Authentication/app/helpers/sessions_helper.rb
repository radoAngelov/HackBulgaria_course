module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies[:user_id] = user.id
    cookies[:remember_digest] = user.remember_digest
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies[:user_id]
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def signed_in?
    !@current_user.nil?
  end

  def sign_out
    forget @current_user
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_digest)
  end
end
