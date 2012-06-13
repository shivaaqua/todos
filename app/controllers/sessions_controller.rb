class SessionsController < ApplicationController
  force_ssl :except => :new
  
  skip_before_filter :authenticate_user!, :except => :destroy

  def new
    render 'new' and return unless auth_hash
    
    record = Authorization.find_or_create_from_hash(auth_hash)

    if record.user_id
      session[:user_id] = record.user_id
      redirect_to tasks_url
    else
      session[:auth_id] = record.id
      session[:provider]= auth_hash[:provider]
      @user             = User.new(:email => record.email)  
      flash.now[:error] = "Your 'My todays task' account is not linked with #{auth_hash[:provider]}.
                            <br />Kindly login in to link it now.
                            If you are a new member signup to continue..".html_safe
      render 'new' and return 
    end  
  end
  
  def failure
    flash.now.alert = 'Unable to connect. Try again later !!!'
    render 'new', :alert => 'Unable to connect. Try again later !!!'
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
    user = User.authenticate(params[:email], params[:password])
    
    unless user
      flash.now[:alert] = "Invalid email or password"
      render "new" and return
    end    
    
    session[:user_id]  = user.id
    
    if session[:auth_id]
      rec = Authorization.find(session[:auth_id]) 
      rec.associate_user(user.id) 
      flash[:notice]     = "Your account is successfully linked with #{session[:provider]}."
      session[:auth_id]  = nil
      session[:provider] = nil
    end
    redirect_to '/tasks' and return
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', :notice => "You are successfuly logged out!"
  end
  
  private
  
  def auth_hash
    request.env['omniauth.auth']
  end
end
