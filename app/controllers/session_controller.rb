class SessionController < ApplicationController
  def new

  end

  def create
    login_params = session_params
    user = User.find_by(email: login_params[:email])

    if user && user.authenticate(login_params[:password])
      session[:user_id] = user.id
      session[:user_role] = user.role
      redirect_to root_path
    else
      render new
    end

  end

  def destroy
    session[:user_id] = nil
    session[:user_role] = nil
    redirect_to root_path
  end

  private

    def session_params
      params.permit(:email, :password)
    end

end
