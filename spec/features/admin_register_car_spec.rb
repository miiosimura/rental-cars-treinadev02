require 'rails_helper'

feature 'Admin register car' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    Subsidiary.create!(name: 'R1', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    CarModel.create!(name: 'Uno', year: '2019', manufacturer_id: 1, fuel_type: 'Flex', motorization: '1.0', category_id: 1)
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros da Frota'
    click_on 'Registrar novo carro para frota'

    fill_in 'Placa', with: 'AAA1234'
    fill_in 'Cor', with: 'Azul'
    fill_in 'Quilometragem', with: '100'
    select 'R1', from: 'Filial'
    select 'Uno', from: 'Modelo'

    click_on 'Enviar'

    expect(page).to have_content('Placa AAA1234')
    expect(page).to have_content('Cor Azul')
    expect(page).to have_content('Quilometragem 100')
    expect(page).to have_content('Filial R1')
    expect(page).to have_content('Modelo Uno')
  end

  scenario 'and must fill in all fields' do
    Manufacturer.create!(name: 'Fiat')
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    Subsidiary.create!(name: 'R1', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    CarModel.create!(name: 'Uno', year: '2019', manufacturer_id: 1, fuel_type: 'Flex', motorization: '1.0', category_id: 1)
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros da Frota'
    click_on 'Registrar novo carro para frota'
    click_on 'Enviar'

    expect(page).to have_content('License plate não pode ser em branco')
    expect(page).to have_content('Color não pode ser em branco')
    expect(page).to have_content('Mileage não pode ser em branco')
    expect(page).to have_content('Mileage deve ser maior igual a 0')
  end

  scenario 'and license plate must be unique' do
    Manufacturer.create!(name: 'Fiat')
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    Subsidiary.create!(name: 'R1', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    CarModel.create!(name: 'Uno', year: '2019', manufacturer_id: 1, fuel_type: 'Flex', motorization: '1.0', category_id: 1)
    Car.create!(license_plate: 'AAA1234', color: 'Vermelho', mileage: '50', subsidiary_id: '1', car_model_id: '1')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros da Frota'
    click_on 'Registrar novo carro para frota'
    fill_in 'Placa', with: 'AAA1234'
    fill_in 'Cor', with: 'Azul'
    fill_in 'Quilometragem', with: '100'
    select 'R1', from: 'Filial'
    select 'Uno', from: 'Modelo'
    click_on 'Enviar'

    expect(page).to have_content('License plate já esta cadastrado no sistema')
  end

  scenario 'and mileage greater the or equal to 0' do
    Manufacturer.create!(name: 'Fiat')
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    Subsidiary.create!(name: 'R1', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    CarModel.create!(name: 'Uno', year: '2019', manufacturer_id: 1, fuel_type: 'Flex', motorization: '1.0', category_id: 1)
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Carros da Frota'
    click_on 'Registrar novo carro para frota'
    fill_in 'Placa', with: 'AAA1234'
    fill_in 'Cor', with: 'Azul'
    fill_in 'Quilometragem', with: '-5'
    select 'R1', from: 'Filial'
    select 'Uno', from: 'Modelo'
    click_on 'Enviar'

    expect(page).to have_content('Mileage deve ser maior igual a 0')
  end

  scenario 'and must be logged in' do
    visit cars_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and link to page disapear if not logged' do
    visit root_path

    expect(page).not_to have_link('Carros da Frota')
  end
end