class ApplicationController < ActionController::Base


  def logged_in?
    !!session[:user]
  end

  def is_coach?
    logged_in? && session[:user_role] == "Coach"
  end


  def is_board?
    logged_in? && session[:user_role] == "Board"
  end

end
