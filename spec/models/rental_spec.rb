require 'rails_helper'

describe Rental  do
  describe '.end_date_must_be_greater_than_start_date' do
    it 'success' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.day.from_now, client: client, category: category, subsidiary: subsidiary)

      rental.valid?

      #expect(rental.errors.empty?).to eq true 
      expect(rental.errors).to be_empty 
    end

    it 'and date less than start date' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.day.from_now, client: client, category: category, subsidiary: subsidiary)

      rental.valid?

      expect(rental.errors.full_messages).to include 'End date deve ser maior que a Data de Inicio'
    end

    it 'end date equal than start date' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.day.from_now, client: client, category: category, subsidiary: subsidiary)

      rental.valid?

      expect(rental.errors.full_messages).to include 'A data de inicio deve ser maior que a data de encerramento  '
    end

    it 'start date must exist' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.day.from_now, client: client, category: category, subsidiary: subsidiary)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas nao podem ser em branco'
    end

    it 'start date must exist' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.day.from_now, client: client, category: category, subsidiary: subsidiary)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas nao podem ser em branco'
    end

    it 'end date must exist' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.day.from_now, client: client, category: category, subsidiary: subsidiary)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas nao podem ser em branco'
    end

    it 'end date must exist' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.day.from_now, client: client, category: category, subsidiary: subsidiary)

      rental.valid?

      expect(rental.errors.full_messages).to include 'Datas nao podem ser em branco'
    end
  end

  describe '.cars_available' do
    it 'should be false if subsidiary has no cars' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, category: category, subsidiary: subsidiary)

      rental.cars_available?

      expect(result).to be false
    end

    it 'should be true if subsidiary has cars' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_model = CarModel.create!(name: 'Uno', year: '2019', manufacturer: manufacturer, fuel_type: 'Flex', motorization: '1.0', category: category)
      Car.create!(car_model: car_model, license_plate: 'AAA1234', color: 'Azul', mileage: '5000', subsidiary: subsidiary)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, category: category, subsidiary: subsidiary)

      rental.cars_available?

      expect(result).to be true
    end

    it 'should be false if subsidiary has no cars from rental category' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      other_category = Category.create!(name: 'B', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_model = CarModel.create!(name: 'Uno', year: '2019', manufacturer: manufacturer, fuel_type: 'Flex', motorization: '1.0', category: category)
      Car.create!(car_model: car_model, license_plate: 'AAA1234', color: 'Azul', mileage: '5000', subsidiary: subsidiary)
      rental = Rental.new(start_date: 1.day.from_now, end_date: 2.days.from_now, client: client, category: other_category, subsidiary: subsidiary)

      rental.cars_available?

      expect(result).to be true
    end

    it 'should be false if subsidiary has rentals scheduled' do
      subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
      client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
      category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
      manufacturer = Manufacturer.create!(name: 'Fiat')
      car_model = CarModel.create!(name: 'Uno', year: '2019', manufacturer: manufacturer, fuel_type: 'Flex', motorization: '1.0', category: category)
      Car.create!(car_model: car_model, license_plate: 'AAA1234', color: 'Azul', mileage: '5000', subsidiary: subsidiary)

      rental_1 = Rental.create!(start_date: 1.day.from_now, end_date: 5.days.from_now, client: client, category: other_category, subsidiary: subsidiary, status: :scheduled)
      rental_2 = Rental.new(start_date: 2.day.from_now, end_date: 3.days.from_now, client: client, category: other_category, subsidiary: subsidiary)

      result = rental.cars_available?

      expect(result).to be false
    end

  end
end
