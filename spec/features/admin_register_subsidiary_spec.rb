require 'rails_helper'

feature 'Admin register subsidiary' do
  scenario 'successfully' do
    visit root_path
    click_on 'Filiais'
    click_on 'Registrar nova filial'

    fill_in 'Nome', with: 'Almeida Cars'
    fill_in 'CNPJ', with: '00.000.000-00'
    fill_in 'Endereço', with: 'Alameda Santos, 1293'
    click_on 'Enviar'

    expect(page).to have_content('Almeida Cars')
    expect(page).to have_content('00.000.000-00')
    expect(page).to have_content('Alameda Santos, 1293')
    expect(page).to have_link('Voltar')
  end

  scenario 'and must fill in all fields' do
    visit new_subsidiary_path
    click_on 'Enviar'

    expect(page).to have_content('Você deve corrigir os seguintes erros:')
    expect(page).to have_content('Name não pode ser em branco')
    expect(page).to have_content('Cnpj não pode ser em branco')
    expect(page).to have_content('Address não pode ser em branco')
  end

  scenario 'and name must be unique' do
    Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')

    visit new_subsidiary_path
    fill_in 'Nome', with: 'Almeida Cars'
    fill_in 'CNPJ', with: '00.000.000-00'
    fill_in 'Endereço', with: 'Alameda Santos, 1293'
    click_on 'Enviar'

    expect(page).to have_content('Name já esta cadastrado no sistema')
    expect(page).to have_content('Cnpj já esta cadastrado no sistema')
  end
end