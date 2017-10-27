module SessionsHelper
    
    #userでlogin(sessionにuserのidを入れる)
    def log_in(user)
        session[:user_id] = user.id #session[]に代入すると勝手に暗号化される
    end
    
    #戻り値としてcurretn_userをとる(current_userはsessionに一時的に保存されたuser)
    def current_user 
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    #current_userがtrueならtrue(Userの中にsession[:user_id]が存在)
    def logged_in?
        !current_user.nil?
    end
    
    def log_out
        session.delete(:user_id)
        @current_user = nil
        flash[:logout] = "Bye"
    end 
end
