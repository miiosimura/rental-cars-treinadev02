class Rental < ApplicationRecord
  belongs_to :client
  belongs_to :category
  validates :start_date, :end_date, :client_id, :category_id, presence: {message: 'não pode ser em branco'}

  validate :end_date_must_be_greater_than_start_date

  def end_date_must_be_greater_than_start_date
    if start_date.blank? || end_date.blank?
      return errors.add(:base, 'Datas nao podem ser em branco')
    end
    
    if end_date < start_date
      errors.add(:end_date, 'deve ser maior que a Data de Inicio')
    end

    if start_date == end_date
      errors.add(:base, 'A data de inicio deve ser maior que a data de encerramento')
    end
  end
end
