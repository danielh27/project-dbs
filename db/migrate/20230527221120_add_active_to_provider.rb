class AddActiveToProvider < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :active, :boolean, default: false
  end
end
