class AddNicknameLastUpdateToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname_last_update, :date
  end
end
