require 'rails_helper'

feature 'Admin edits subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')

    visit root_path
    click_on 'Filiais'
    click_on 'Almeida Cars'
    click_on 'Editar'
    fill_in 'Nome', with: 'Alameda Cars'
    click_on 'Enviar'

    expect(page).to have_content('Alameda Cars')
  end

  scenario 'and must fill in all fields' do
    Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')

    visit root_path
    click_on 'Filiais'
    click_on 'Almeida Cars'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Name não pode ser em branco')
    expect(page).to have_content('Cnpj não pode ser em branco')
    expect(page).to have_content('Address não pode ser em branco')
  end

  scenario 'and must be unique' do
    Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    Subsidiary.create!(name: 'R1 System', cnpj: '11.111.111-11', address: 'Rua Banana, 123')

    visit root_path
    click_on 'Filiais'
    click_on 'Almeida Cars'
    click_on 'Editar'
    fill_in 'Nome', with: 'R1 System'
    fill_in 'CNPJ', with: '11.111.111-11'
    click_on 'Enviar'

    expect(page).to have_content('Name já esta cadastrado no sistema')
    expect(page).to have_content('Cnpj já esta cadastrado no sistema')
  end
end