class Manufacturer < ApplicationRecord
  validates :name, presence: {message: 'não pode ser em branco'}
  validates :name, uniqueness: {message: 'já esta cadastrado no sistema'}
end
