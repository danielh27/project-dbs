class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :main_address, null: false
      t.string :secondary_address
      t.references :user, null: false, foreign_key: true
      t.string :city, null: false
      t.string :state
      t.string :country, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.string :zipcode, null: false

      t.timestamps
    end
  end
end
