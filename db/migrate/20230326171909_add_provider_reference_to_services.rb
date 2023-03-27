class AddProviderReferenceToServices < ActiveRecord::Migration[7.0]
  def change
    add_reference :services, :provider, null: false, foreign_key: true
  end
end
