module SessionsHelper
    
    #userでlogin(sessionにuserのidを入れる)
    def log_in(user)
        session[:user_id] = user.id #session[]に代入すると勝手に暗号化される
    end
    
    #戻り値としてcurretn_userをとる(current_userはsessionに一時的に保存されたuser)
    def current_user #current_userはloginしているかどうかの確認に使うよ
        if session[:user_id]
           @current_user ||= User.find_by(id: session[:user_id])
        elsif cookies.signed[:user_id] #user_idがsessionになくてもcookiesにあるならログインさせようではない
           user = User.find_by(id: cookies[:user_id])
           if user && user.authenticaed?(cookies[:remember_token])
               #User内にcookiesのuser_idがあり、Userのremember_digestとcookiesのremember_tokenが一致
               log_in(user)
               @current_user = user 
           end 
        end
    end
    
    #current_userがtrueならtrue(Userの中にsession[:user_id]が存在)
    def logged_in?
        !current_user.nil?
    end
    
    def log_out
        forget_remember_digest_and_cookies
        session.delete(:user_id)
        @current_user = nil
        flash[:logout] = "Bye"
    end 
    
    def create_cookies(user)
        user.make_remember_digest #modelUserのremember,Userのremember_digestの更新
        cookies.permanent.signed[:user_id] = user.id 
        cookies.permanent[:remember_token] = user.remember_digest
        #cookiesの作成
    end
    
    def forget_remember_digest_and_cookies
        @current_user.forget_remember_digest
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end
    
end
