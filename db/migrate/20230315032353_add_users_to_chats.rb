class AddUsersToChats < ActiveRecord::Migration[7.0]
  def change
    add_reference :chats, :client, null: false, foreign_key: { to_table: :users }, index: true
    add_reference :chats, :provider, null: false, foreign_key: { to_table: :users }, index: true
  end
end
