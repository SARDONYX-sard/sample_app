module SessionsHelper
    # 渡されたユーザーでログインする
    # ユーザーのブラウザ内の一時cookiesに暗号化済みのユーザーIDが自動で作成
    # session[:user_id]を使ってユーザーIDを復号
    # sessionメソッドで作成された一時cookiesは、
    # ブラウザを閉じた瞬間に有効期限が終了します
    def log_in(user)
        session[:user_id] = user.id
    end

    # 現在ログイン中のユーザーを返す (いる場合)
    def current_user
        # 以下のコードの省略形
        # @current_user = @current_user || User.find_by(id: session[:user_id])
        # 変数の値がnilなら変数に代入するが、
        # nilでなければ代入しない (変数の値を変えない
        @current_user ||= User.find_by(id: session[:user_id])
    end

    # ユーザーがログインしていればtrue、その他ならfalseを返す
    def logged_in?
        !current_user.nil?
    end

    # 現在のユーザーをログアウトする
    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
