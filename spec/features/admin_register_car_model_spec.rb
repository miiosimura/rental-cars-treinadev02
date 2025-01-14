require 'rails_helper'

feature 'Admin register car model' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Chevrolet')
    Manufacturer.create!(name: 'Honda')
    Category.create!(name: 'A', daily_rate: 100, car_insurance: 50, third_party_insurance: 90)
    Category.create!(name: 'B', daily_rate: 200, car_insurance: 150, third_party_insurance: 190)
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Modelos de Carro'
    click_on 'Registrar novo modelo'

    fill_in 'Nome', with: 'Onix'
    fill_in 'Ano', with: '2020'
    fill_in 'Motorização', with: '1.0'
    fill_in 'Combustivel', with: 'Flex'
    select 'Chevrolet', from: 'Fabricante'
    select 'A', from: 'Categoria'
    
    click_on 'Enviar'

    expect(page).to have_content('Modelo registrado com sucesso!')
    expect(page).to have_content('Onix')
    expect(page).to have_content('Ano: 2020')
    expect(page).to have_content('Motorização: 1.0')
    expect(page).to have_content('Combustivel: Flex')
    expect(page).to have_content('Fabricante: Chevrolet')
    expect(page).to have_content('Categoria: A')
  end

  scenario 'and must be logged in' do
    visit car_models_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and link to page disapear if not logged' do
    visit root_path

    expect(page).not_to have_link('Modelos de Carro')
  end
end