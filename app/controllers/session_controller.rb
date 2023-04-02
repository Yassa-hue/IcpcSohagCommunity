class SessionController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path
    end
  end

  def create
    login_params = session_params
    user = User.find_by(email: login_params[:email])

    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      session[:user_role] = user.role
      session[:user_name] = user.name
      redirect_to root_path
    else
      render new
    end

  end

  def destroy
    session[:user_id] = nil
    session[:user_role] = nil
    session[:user_name] = nil
    redirect_to root_path
  end

  private

    def session_params
      params.permit(:email, :password)
    end

end
