〇サインアップ
メール送信 => メールのurlよりAccountActivateのeditへ
=> activate and log_in(create session) => redirect_to user

〇ログイン&ログアウト
・ログインする
log_in => sessionを作成(if user.activated?)

sessionが作成されると...
@current_userにsessionのuser_idが入りtrueを返す
(@curretn_userはcookiesにuser_idが入っていればtrueになる)


・ログインの確認
logged_in?(ログインしているかの確認)
@current_userがtrueならログインとみなす


・ログアウトする
log_out => sessionをdestroy, @current_userをnilにする
           remember_digestとcookiesの破壊


〇サインアップ(新しいUser)
formでsubmitされた値をparamsで受け取り@userに入れて、@userでlog_in(session作成)


〇sessionの作成
log_in時作成(サインアップとログイン時、チェックボックスは関係なし)
(def log_in(user)
　session[:user_id] = user.id #session[]に代入すると勝手に暗号化される
end)
※log_inはuser_controllerとsession_controllerのcreateで使用

〇cookiesの作成
ログイン時チェックボックスにチェックを入れると作成
session_helperのcreate_cookies
Userのcreate_remember_digestが必要(ここでtokenとか使う)
cookiesはuser_idとremember_tokenの値を持つ

〇userの編集(edit,update)の前にやること(before_action)
logged_in? => ログインしているか(current_userの確認(sessionかcookiesがあるか)
store_location => 不適切なuserが元居たpageへ戻れるように

