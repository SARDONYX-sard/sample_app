class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
    def change
        # usersテーブルのemailカラムにインデックスを追加
        # add_indexというRailsのメソッドを使用
        add_index :users, :email, unique: true
    end
end
