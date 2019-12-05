class Subsidiary < ApplicationRecord
  validates :name, :cnpj, :address, presence: {message: 'não pode ser em branco'}
  validates :name, :cnpj, uniqueness: {message: 'já esta cadastrado no sistema'}
  has_many :cars
end
