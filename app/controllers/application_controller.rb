class ApplicationController < ActionController::Base
  helper_method :logged_in?, :is_board?

  def logged_in?
    !!session[:user_id]
  end

  def is_coach?
    logged_in? && session[:user_role] == "Coach"
  end


  def is_board?
    logged_in? && session[:user_role] == "Board"
  end



  def require_board
    unless is_board?
      flash[:alert] = "You don't have permission to create, edit or destroy posts."
      redirect_to login_path
    end
  end


  def require_login
    unless logged_in?
      flash[:alert] = "You don't have permission to enter this page."
      redirect_to login_path
    end
  end


end
