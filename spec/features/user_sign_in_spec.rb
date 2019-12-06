require 'rails_helper'

feature 'user sign in' do
  scenario 'successfully' do
    user = User.create!(email: 'email@teste.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'

    expect(current_path).to eq(root_path) #current_path direciona para a pagina
    expect(page).to have_content('Signed in successfully')
    expect(page).not_to have_link('Entrar')
    expect(page).to have_link('Sair')
  end

  scenario 'and log out' do
    user = User.create!(email: 'email@teste.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'Email', with: user.email
    fill_in 'Senha', with: user.password
    click_on 'Log in'
    click_on 'Sair'

    expect(current_path).to eq(root_path) #current_path direciona para a pagina
    expect(page).to have_content('Signed out successfully')
    expect(page).not_to have_link('Sair')
    expect(page).to have_link('Entrar')
  end
end