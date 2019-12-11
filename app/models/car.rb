class Car < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :car_model #belongs = amarracao forte, precisa ter. #has_one = amarracao fraca, pode ser nil

  has_one :category, through: :car_model
  
  has_many :car_rentals
  has_many :rentals, through: :car_rentals

  validates :license_plate, :color, :mileage, :subsidiary_id, :car_model_id, presence: {message: 'não pode ser em branco'}
  validates :license_plate, uniqueness: {message: 'já esta cadastrado no sistema'}
  validates :mileage, numericality: {greater_than_or_equal_to: 0, message: 'deve ser maior igual a 0'}

  enum status: {available: 0, unavailable: 1}

  def name
    "#{car_model.name} - #{license_plate}"
  end

  def price
    category.daily_rate + category.car_insurance + category.third_party_insurance
  end
end
