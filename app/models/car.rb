class Car < ApplicationRecord
  belongs_to :subsidiary
  belongs_to :car_model

  validates :license_plate, :color, :mileage, :subsidiary_id, :car_model_id, presence: {message: 'não pode ser em branco'}
  validates :license_plate, uniqueness: {message: 'já esta cadastrado no sistema'}
  validates :mileage, numericality: {greater_than_or_equal_to: 0, message: 'deve ser maior igual a 0'}
end
