class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @user = current_user if current_user
      @feed_item = current_user.microposts.all
    end
  end

  def help
    @title="help"
  end
  
  def about 
    @title="about"
  end 
  
  
end
