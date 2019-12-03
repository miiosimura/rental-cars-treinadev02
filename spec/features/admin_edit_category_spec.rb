require 'rails_helper'

feature 'Admin edits category' do
  scenario 'successfully' do
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    
    visit root_path
    click_on 'Categorias'
    click_on 'Familiar'
    click_on 'Editar'
    fill_in 'Nome', with: 'Sedã'
    click_on 'Enviar'

    expect(page).to have_content('Sedã')
  end

  scenario 'and must fill in all fields' do
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')

    visit root_path
    click_on 'Categorias'
    click_on 'Familiar'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Diária', with: ''
    fill_in 'Seguro do Carro', with: ''
    fill_in 'Seguro contra Terceiros', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Name não pode ser em branco')
    expect(page).to have_content('Daily rate não pode ser em branco')
    expect(page).to have_content('Car insurance não pode ser em branco')
    expect(page).to have_content('Third party insurance não pode ser em branco')
  end

  scenario 'and name must be unique' do
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    Category.create!(name: 'Sedã', daily_rate: '200', car_insurance: '60', third_party_insurance: '40')

    visit root_path
    click_on 'Categorias'
    click_on 'Familiar'
    click_on 'Editar'
    fill_in 'Nome', with: 'Sedã'
    click_on 'Enviar'

    expect(page).to have_content('Name já esta cadastrado no sistema')
  end
end