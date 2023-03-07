class CreateServices < ActiveRecord::Migration[7.0]
  def change
    create_table :services do |t|
      t.string :name, null: false
      t.string :description
      t.integer :price, default: 0
      t.boolean :active, default: false
      t.string :slug
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
