class CarModel < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :category
  has_many :cars

  validates :name, :year, :manufacturer_id, :fuel_type, :motorization, :category_id, presence: {message: 'não pode ser em branco'}
end
