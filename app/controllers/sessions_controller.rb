class SessionsController < ApplicationController
  
  #login page へ飛ぶ
  def new
    @title = "Log in"
  end
  
  #loginを扱う
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])#Userのdb内のpassword_digestとsubmitされたpasswordの比較
      log_in(user)
      redirect_to user 
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
 
  
  def destroy
    log_out 
    redirect_to root_url
  end
  
end
