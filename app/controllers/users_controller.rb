class UsersController < ApplicationController
    before_action :logged_in_user, only: [:index, :edit, :update, :delete]
    before_action :correct_user, only: [:edit, :update]
    before_action :user_admin?, only: [:destroy]
    
    def new
      @user = User.new(params[:user])
      @title = 'signup'
    end
   
    def index 
      @users = User.all
    end
  
    def show
      @user = User.find_by(id: params[:id])
      @title = @user.name
      @microposts = @user.microposts.all
    end
    
    #signupを扱う
    def create 
      @user = User.new(user_params) #params => user => name,email,password...
      if @user.save 
        @user.update_attributes(:admin, true)
        log_in(@user) #session に@userを登録
        flash[:success] = "Complete Sign up"
        redirect_to @user
      else 
        render 'new'
      end
    end
    
    def edit 
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        @user.admin.update_attributes(:admin)
        flash[:update] = 'changed setting'
        redirect_to @user 
      else 
        render 'edit'
      end 
    end
    
    def destory
      User.find(params[:id]).destory
      redirect_to users_path
    end
  
    private
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmatio)
      end
      
       #正しいuserの確認
       def correct_user
         @user = User.find(params[:id])
         redirect_to root_url unless @user == current_user
       end
       
       def user_admin?
         redirect_to(users_path) unless current_user.admin?
       end
end 