class StaticPagesController < ApplicationController
  
  helper_method :full_title
  
  def home
  end

  def help
    @title="help"
  end
  
  def about 
    @title="about"
  end 
  
  def full_title(title)
        base_title = "Ruby on Rails Tutorial"
        if title 
            title + '|' + base_title
        else
            base_title
        end
  end
end
