class Category < ApplicationRecord
  validates :name, :daily_rate, :car_insurance, :third_party_insurance, presence: {message: 'não pode ser em branco'}
  validates :name, uniqueness: {message: 'já esta cadastrado no sistema'}
  has_many :car_models
  has_many :cars, through: :car_models #o through permite fazer join de forma mais simplificada. Seu valor deve ser do has_many que ja esta na classe

  #category tem muitos car_models. Para conseguir puxar os dados de car_model em rental (que possui category), chamar com through
end
