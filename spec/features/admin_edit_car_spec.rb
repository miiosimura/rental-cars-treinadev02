require 'rails_helper'

feature 'Admin edits car' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    Subsidiary.create!(name: 'R1', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    CarModel.create!(name: 'Uno', year: '2019', manufacturer_id: 1, fuel_type: 'Flex', motorization: '1.0', category_id: 1)
    Car.create!(license_plate: 'AAA1234', color: 'Vermelho', mileage: '50', subsidiary_id: '1', car_model_id: '1')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros da Frota'
    click_on 'AAA1234'
    click_on 'Editar'
    fill_in 'Placa', with: 'BBB5678'
    click_on 'Enviar'

    expect(page).to have_content('Placa BBB5678')
  end

  scenario 'and must fill in all fields' do
    Manufacturer.create!(name: 'Fiat')
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    Subsidiary.create!(name: 'R1', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    CarModel.create!(name: 'Uno', year: '2019', manufacturer_id: 1, fuel_type: 'Flex', motorization: '1.0', category_id: 1)
    Car.create!(license_plate: 'AAA1234', color: 'Vermelho', mileage: '50', subsidiary_id: '1', car_model_id: '1')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros da Frota'
    click_on 'AAA1234'
    click_on 'Editar'
    fill_in 'Placa', with: ''
    click_on 'Enviar'

    expect(page).to have_content('License plate não pode ser em branco')
  end
end