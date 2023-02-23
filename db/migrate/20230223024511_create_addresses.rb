class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :main_address
      t.string :secondary_address
      t.references :user, null: false, foreign_key: true
      t.string :city
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude
      t.string :zipcode

      t.timestamps
    end
  end
end
