require 'rails_helper'

feature 'Visitor view manufacturers' do
  scenario 'successfully' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'

    expect(page).to have_content('Fiat')
    expect(page).to have_link('Voltar')
  end

  scenario 'and return to home page' do
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Volkswagen')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)
    
    login_as(user, scope: :user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end