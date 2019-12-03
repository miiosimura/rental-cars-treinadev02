class Client < ApplicationRecord
  validates :name, :cpf, :email, presence: {message: 'não pode ser em branco'}
  validates :cpf, :email, uniqueness: {message: 'ja esta cadastrado no sistema'}
end
