class Category < ApplicationRecord
  validates :name, :daily_rate, :car_insurance, :third_party_insurance, presence: {message: 'não pode ser em branco'}
  validates :name, uniqueness: {message: 'já esta cadastrado no sistema'}
  has_many :car_models
end
