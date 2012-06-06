class SessionsController < ApplicationController
  force_ssl :except => :new
  
  skip_before_filter :authenticate_user!, :except => :destroy

  def new
  end
  
  def failure
    raise 'failure'
  end
=begin  
  
  def create
    #raise auth_hash.inspect
    #@user = User.find_or_create_from_auth_hash(auth_hash)
    #self.current_user = @user
    #redirect_to '/'
  end
=end  
  def create
    authenticate_user and return unless auth_hash
    auth_account = Authorization.find_from_hash(auth_hash)    
    
    if auth_account.try(:user_id)
      session[:user_id] = auth_account.user_id  
      redirect_to '/tasks' and return
    else    
      auth_account      = Authorization.create_from_hash(auth_hash)
      session[:auth_id] = auth_account.id
      @user             = User.new(:email => auth_account.email)  
      render 'sessions/new' and return
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', :notice => "Logged out!"
  end
  
  private
  
  def auth_hash
    request.env['omniauth.auth']
  end
  
  def authenticate_user
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      user.associate_account(session[:auth_id]) if session[:auth_id]
      session[:auth_id] = nil 
      redirect_to root_url
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
end
