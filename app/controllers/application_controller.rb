class ApplicationController < ActionController::Base
  force_ssl
  before_filter :set_locale
  before_filter :authenticate_user!


  protect_from_forgery
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private
  
  def authenticate_user!
    if !current_user
      redirect_to "/#{I18n.locale}/login", :notice => "You need to sign in to continue"
    end
  end    
  
  def set_locale
    #session[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = params[:locale] if params[:locale].present?
  end
  
  def default_url_options(options = {})
    {locale: I18n.locale}
  end
  
end
