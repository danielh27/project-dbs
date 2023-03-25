class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :ruc
      t.string :legal_representant

      t.timestamps
    end
  end
end
