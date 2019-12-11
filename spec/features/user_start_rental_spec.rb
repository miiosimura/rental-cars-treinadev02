require 'rails_helper'

feature 'User start rental' do
  scenario 'successfully' do
    subsidiary = Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000/0000-00', address: 'Alameda Santos, 123')
    user = User.create!(email: 'teste@teste.com', password: '123456', role: :employee)
    client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
    category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
    manufacturer = Manufacturer.create!(name: 'Chevrolet')
    car_model = CarModel.create!(name: 'Onix', year: '2020', manufacturer: manufacturer, fuel_type: 'Flex', motorization: '1.0', category: category)
    car = Car.create!(car_model: car_model, license_plate: 'ABC1234', color: 'Preto', mileage: 0, subsidiary: subsidiary)
    rental = Rental.create!(client: client, category: category, start_date: 1.day.from_now, end_date: 2.days.from_now, reservation_code: 'ABC1234', rental_status: :scheduled)

    login_as(user, scope: :user)
    visit rental_path(rental)
    select "#{car_model.name} - #{car.license_plate}", from: 'Carro'
    click_on 'Iniciar Locação'

    expect(page).to have_content('Locação iniciada com sucesso!')
    expect(page).not_to have_button('Iniciar Locação')
    rental.reload
    car.reload
    expect(rental).to be_in_progress
    expect(car).not_to be_available
  end
end