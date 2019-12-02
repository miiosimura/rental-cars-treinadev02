require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and must fill in all fields' do
    visit new_manufacturer_path
    #fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Name não pode ser em branco')
  end

  scenario 'and name must be unique' do
    Manufacturer.create!(name: 'Fiat')
    
    visit new_manufacturer_path
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Name já esta cadastrado no sistema')
  end
end