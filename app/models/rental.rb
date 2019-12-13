class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :category
  belongs_to :subsidiary

  has_one :car_rental
  has_one :car, through: :car_rental

  validates :start_date, :end_date, :client_id, :category_id, presence: {message: 'não pode ser em branco'}

  enum rental_status: [:scheduled, :in_progress]

  validate :end_date_must_be_greater_than_start_date, :start_date_equal_or_greater_than_today
  validate :cars_available, on: :create

  def end_date_must_be_greater_than_start_date
    return unless start_date.present? && end_date.present?

    if end_date <= start_date
      errors.add(:end_date, 'deve ser maior que a Data de Inicio')
    end
  end

  def start_date_equal_or_greater_than_today
    return unless start_date.present?

    if start_date < Date.current #nao usar Date.today, ele nao usa timezone
      errors.add(:start_date, 'deve ser maior que a data de hoje')
    end
  end

  def cars_available
    return unless start_date.present? && end_date.present?

    if cars_available_at_date_range
      errors.add(:category, '')
    end
  end
end
