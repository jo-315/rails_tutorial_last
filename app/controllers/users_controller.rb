class UsersController < ApplicationController
  def new
    @user = User.new(params[:user])
    @title = 'signup'
  end
  
  def show
    @user = User.find_by(id: params[:id])
    @title = @user.name
  end 
  
  #signupを扱う
  def create 
    @user = User.new(user_params) #params => user => name,email,password...
     if @user.save 
       log_in(@user) #session に@userを登録
       flash[:success] = "Complete Sign up"
       redirect_to @user
     else 
       render 'new'
     end
  end
  
  
  private 
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
      
end
