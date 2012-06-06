class ApplicationController < ActionController::Base
  force_ssl

  before_filter :authenticate_user!

  protect_from_forgery
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private
  def authenticate_user!
    if !current_user
      redirect_to '/login', :notice => "You need to sign in to continue"
    end
  end    
  
end
