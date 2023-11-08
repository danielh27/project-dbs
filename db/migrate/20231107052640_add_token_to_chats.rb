class AddTokenToChats < ActiveRecord::Migration[7.0]
  def change
    add_column :chats, :token, :string, index: { unique: true }
  end
end
