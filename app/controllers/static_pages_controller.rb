class StaticPagesController < ApplicationController
  def home
    @title="home"
  end

  def help
    @title="help"
  end
  
  def about 
    @title="about"
  end 
end
