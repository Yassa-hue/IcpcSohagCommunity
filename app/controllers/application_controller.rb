class ApplicationController < ActionController::Base


  def logged_in?
    !!session[:user]
  end

  def is_coach?
    logged_in? && session[:user].role == :coach
  end


  def is_board?
    logged_in? && session[:user].role == :board
  end

end
