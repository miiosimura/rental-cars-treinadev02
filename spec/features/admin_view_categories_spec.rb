require 'rails_helper'

feature 'Admin viewer categories' do
  scenario 'successfully' do
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'
    click_on 'Familiar'
    
    expect(page).to have_content('Familiar')
    expect(page).to have_content('100')
    expect(page).to have_content('50')
    expect(page).to have_content('25')
    expect(page).to have_link('Voltar')
  end

  scenario 'and view categories links' do
    Category.create!(name: 'Familiar', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    Category.create!(name: 'Sedã', daily_rate: '100', car_insurance: '50', third_party_insurance: '25')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Categorias'

    expect(page).to have_link('Familiar')
    expect(page).to have_link('Sedã')
  end

  scenario 'and no category exists' do
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(user, scope: :user)    
    visit root_path
    click_on 'Categorias'

    expect(page).to have_content('Não existem categorias cadastradas no sistema')
  end
end