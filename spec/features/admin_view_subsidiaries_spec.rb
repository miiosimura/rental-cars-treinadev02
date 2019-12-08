require 'rails_helper'

feature 'Admin viewer subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Almeida Cars'
    
    expect(page).to have_content('Almeida Cars')
    expect(page).to have_content('00.000.000-00')
    expect(page).to have_content('Alameda Santos, 1293')
  end

  scenario 'and view subsidiaries links' do
    Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    Subsidiary.create!(name: 'R1 System', cnpj: '11.111.111-11', address: 'Rua Banana, 123')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_link('Almeida Cars')
    expect(page).to have_link('R1 System')
  end
  
  scenario 'and no subsidiary exists' do
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)    
    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_content('Não existem filiais cadastradas no sistema')
  end

  scenario 'and must be logged in' do
    visit subsidiaries_path

    expect(current_path).to eq new_user_session_path
  end

  #scenario 'and must be logged in' do
    #visit root_path

    #expect(page).not_to have_link('Filiais')
  #end
end