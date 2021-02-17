class SessionsController < ApplicationController
    def new; end

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            # ユーザーログイン後にユーザー情報のページにリダイレクトする
            # helperに登録したlog_inメソッド
            log_in user

            # プロフィールページへ自動変換後、ルーティング
            redirect_to user
        else
            flash.now[:danger] = 'Invalid email/password combination'
            render 'new'
        end
    end

    def destroy
        log_out
        redirect_to root_url
    end
end
