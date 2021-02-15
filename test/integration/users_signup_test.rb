require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    test 'invalid signup information' do
        # ------ 以下コードと等価 -------KK-----------
        # before_count = User.count
        # post users_path, ...
        # after_count  = User.count
        # assert_equal before_count, after_count
        # -------------------------------------------
        # user.createに誤ったPOST値をPOSTしても
        # データベース個数がPOST前と後で変わらないかテスト
        get signup_path
        assert_no_difference 'User.count' do
            post users_path,
                 params: {
                     user: {
                         name: '',
                         email: 'user@invalid',
                         password: 'foo',
                         password_confirmation: 'bar',
                     },
                 }
        end
    end

    test 'valid signup information' do
        get signup_path
        assert_difference 'User.count', 1 do
            post users_path,
                 params: {
                     user: {
                         name: 'Example User',
                         email: 'user@example.com',
                         password: 'password',
                         password_confirmation: 'password',
                     },
                 }
        end

        # POSTリクエストを送信した結果を見て、リダイレクト先に移動するメソッド
        follow_redirect!

        # showにリダイレクトされているか
        assert_template 'users/show'
        assert_not flash.empty?
    end
end
