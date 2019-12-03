require 'rails_helper'

feature 'User register client' do
  scenario 'successfully' do
    visit root_path
    click_on 'Clientes'
    click_on 'Registrar novo cliente'

    fill_in 'Nome', with: 'João'
    fill_in 'CPF', with: '12345678900'
    fill_in 'Email', with: 'joao@email.com'
    click_on 'Enviar'

    expect(page).to have_content('João')
    expect(page).to have_content('12345678900')
    expect(page).to have_content('joao@email.com')
    expect(page).to have_link('Voltar')
  end

  scenario 'and must fill in all fields' do
    visit new_client_path
    click_on 'Enviar'

    expect(page).to have_content('Name não pode ser em branco')
    expect(page).to have_content('Cpf não pode ser em branco')
    expect(page).to have_content('Email não pode ser em branco')
  end

  scenario 'and cpf must be unique' do
    Client.create!(name: 'João', cpf: '12345678900', email: 'joao@email.com')

    visit new_client_path
    fill_in 'Nome', with: 'Maria'
    fill_in 'CPF', with: '12345678900'
    fill_in 'Email', with: 'maria@email.com'
    click_on 'Enviar'

    expect(page).to have_content('Cpf ja esta cadastrado no sistema')
  end

  scenario 'and email must be unique' do
    Client.create!(name: 'João', cpf: '12345678900', email: 'joao@email.com')

    visit new_client_path
    fill_in 'Nome', with: 'Maria'
    fill_in 'CPF', with: '98765432100'
    fill_in 'Email', with: 'joao@email.com'
    click_on 'Enviar'

    expect(page).to have_content('Email ja esta cadastrado no sistema')
  end
end