class Address < ApplicationRecord
  belongs_to :user
  
  def test
    "hola"
  end
end
