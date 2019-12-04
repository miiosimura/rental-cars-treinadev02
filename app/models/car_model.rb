class CarModel < ApplicationRecord
  validates :name, presence: true
  belongs_to :manufacturer
  belongs_to :category
end
