require 'rails_helper'

describe Rental  do
  describe '.end_date_must_be_greater_than_start_date' do
    it 'success' do
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '09/12/2019', end_date: '12/12/2019', client: client, category: category)

      rental.valid?

      #expect(rental.errors.empty?).to eq true 
      expect(rental.errors).to be_empty 
    end

    it 'and date less than start date' do
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '09/12/2019', end_date: '08/12/2019', client: client, category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'End date deve ser maior que a Data de Inicio'
    end

    #it 'end date equal than start date' do
    #end

    it 'start date must exist' do
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: 'nil', end_date: '08/12/2019', client: client, category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas nao podem ser em branco'
    end

    it 'start date must exist' do
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '', end_date: '08/12/2019', client: client, category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas nao podem ser em branco'
    end

    it 'end date must exist' do
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '08/12/2019', end_date: 'nil', client: client, category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas nao podem ser em branco'
    end

    it 'end date must exist' do
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: '08/12/2019', end_date: '', client: client, category: category)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas nao podem ser em branco'
    end
  end
end
