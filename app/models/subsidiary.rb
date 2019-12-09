class Subsidiary < ApplicationRecord
  has_many :cars, dependent: :destroy #:nullify  , :delete,  :restrict_with_error
  
  validates :name, :cnpj, :address, presence: {message: 'não pode ser em branco'}
  validates :name, :cnpj, uniqueness: {message: 'já esta cadastrado no sistema'}
end
