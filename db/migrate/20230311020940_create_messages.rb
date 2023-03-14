class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :chat, null: false, foreign_key: true, index: true
      t.references :client, null: false, foreign_key: { to_table: :users }, index: true
      t.references :provider, null: false, foreign_key: { to_table: :users }, index: true

      t.timestamps
    end
  end
end
