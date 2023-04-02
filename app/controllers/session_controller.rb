class SessionController < ApplicationController
  def new

  end

  def create
    login_params = session_params
    user = User.find_by(email: login_params[:email])

    if user && user.authenticate(login_params[:password])
      session[:user] = user
      redirect_to root_path
    else
      render new
    end

  end

  def destroy
    session[:user] = nil
  end

  private

    def session_params
      params.permit(:email, :password)
    end

end
