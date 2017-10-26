class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  helper_method :full_title
  
  def full_title(title)
        base_title = "Ruby on Rails Tutorial"
        if title 
            title + '|' + base_title
        else
            base_title
        end
  end
end
