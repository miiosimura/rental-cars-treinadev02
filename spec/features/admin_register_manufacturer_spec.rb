require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and must fill in all fields' do
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)
    
    login_as(user, scope: :user)
    visit new_manufacturer_path
    #fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Name não pode ser em branco')
  end

  scenario 'and name must be unique' do
    Manufacturer.create!(name: 'Fiat')
    admin = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(admin, scope: :user)
    visit new_manufacturer_path
    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Name já esta cadastrado no sistema')
  end

  scenario 'and must be logged in' do
    visit manufacturers_path

    expect(current_path).to eq new_user_session_path
  end

  scenario 'and link to page disapear if not logged' do
    visit root_path

    expect(page).not_to have_link('Fabricantes')
  end
end