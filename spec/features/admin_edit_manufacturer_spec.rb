require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    Manufacturer.create!(name: 'Fiat')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
  end

  scenario 'and must fill in all fields' do
    Manufacturer.create!(name: 'Fiat')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Name não pode ser em branco')
  end

  scenario 'and must be unique' do
    Manufacturer.create!(name: 'Fiat')
    Manufacturer.create!(name: 'Honda')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Name já esta cadastrado no sistema')
  end

  scenario 'and must be logged in' do
    visit new_manufacturer_path

    expect(current_path).to eq new_user_session_path
  end

  #scenario 'and link to page disapear if not logged' do
    #visit root_path

    #expect(page).not_to have_link('Fabricantes')
  #end
end