class ApplicationController < ActionController::Base
 helper :all
 helper_method :current_user
 
 protect_from_forgery

  
  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to root_url
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private
  
  def logged_in?
    !!current_user
  end

end
