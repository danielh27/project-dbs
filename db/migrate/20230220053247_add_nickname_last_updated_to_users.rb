class AddNicknameLastUpdatedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nickname_last_updated, :date
  end
end
