class SessionsController < ApplicationController
  def new
  end
  
  def create
    #raise auth_hash.inspect
    #@user = User.find_or_create_from_auth_hash(auth_hash)
    #self.current_user = @user
    #redirect_to '/'
  end
  
=begin  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
=end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
  protected
  def auth_hash
    request.env['omniauth.auth']
  end
    
end
