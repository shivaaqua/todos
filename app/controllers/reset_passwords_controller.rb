class ResetPasswordsController < ApplicationController

  skip_before_filter :authenticate_user!
  
  def new
  end
  
  def create
    unless params[:email].present?
      flash.now.alert = 'Enter your email id to continue..'
      render 'new' and return
    end
    user = User.find_by_email(params[:email])
    user.send_new_password if user
    redirect_to new_reset_password_url, :notice => "You will receive an email with password 
                                                    reset instruction if your email exist 
                                                    in our database"
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_expired?
      redirect_to new_reset_password_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

end
