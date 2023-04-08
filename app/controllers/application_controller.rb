class ApplicationController < ActionController::Base
  helper_method :logged_in?, :is_trainee?, :is_board?, :is_coach?,:current_user_id, :current_user_name

  def current_user_name
    session[:user_name]
  end

  def current_user_id
    session[:user_id]
  end

  def logged_in?
    !!session[:user_id]
  end


  def is_trainee?
    logged_in? && session[:user_role] == "Trainee"
  end

  def is_coach?
    logged_in? && session[:user_role] == "Coach"
  end


  def is_board?
    logged_in? && session[:user_role] == "Board"
  end



  def require_board
    unless is_board?
      flash[:alert] = "You don't have permission to enter this page."
      redirect_to login_path
    end
  end


  def require_login
    unless logged_in?
      flash[:alert] = "You don't have permission to enter this page."
      redirect_to login_path
    end
  end


  def require_coach_or_board
    unless is_board? || is_coach?
      flash[:alert] = "You don't have permission to enter this page."
      redirect_to login_path
    end
  end


end
