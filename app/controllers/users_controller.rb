class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        # params[:user]はnew.htmlからPOSTで送られてきた値
        @user = User.new(user_params)
        if @user.save
            log_in @user
            flash[:success] = 'Welcome to the Sample App!'

            # このコードと等価`redirect_to user_url(@user)`
            redirect_to @user
        else
            # users/new.html.erbを描画
            render 'new'
        end
    end

    # privateキーワードで以下の関数はここだけでしか使用できないようにさせる
    # privateキーワード以降のコードを強調するために、
    # user_paramsのインデントが1段深い
    private

    def user_params
        params
            # user属性を必須化
            .require(:user)
            # 名前、メールアドレス、パスワード、パスワードの確認の属性[のみ]許可
            .permit(:name, :email, :password, :password_confirmation)
    end
end
