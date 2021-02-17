class User < ApplicationRecord
    # Userモデルの中では右式のselfを省略できる(self.email = self.email.downcase)
    # selfは現在のユーザーを指します
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
    validates :email,
              presence: true,
              length: {
                  maximum: 255,
              },
              format: {
                  with: VALID_EMAIL_REGEX,
              },
              uniqueness: {
                  case_sensitive: false,
              }

    # パスワード（文字列）をハッシュでデータベースに保管。gem 'bcrypt'が必須
    has_secure_password

    # 空でないこと。presence: true,
    validates :password, presence: true, length: { minimum: 6 }

    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost =
            if ActiveModel::SecurePassword.min_cost
                BCrypt::Engine::MIN_COST
            else
                BCrypt::Engine.cost
            end
        BCrypt::Password.create(string, cost: cost)
    end
end
