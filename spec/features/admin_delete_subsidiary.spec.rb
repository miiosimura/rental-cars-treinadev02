require 'rails_helper'

feature 'Admin delete a subsidiary' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    user = User.create!(email: 'email@teste.com', password: '123456', role: :admin)

    login_as(scope: :user)
    visit root_path
    click_on 'Filiais'
    click_on 'Almeida Cars'
    click_on 'Excluir Filial'

    expect(current_path).to eq subsidiaries_path
    expect(page).not_to have_link('Almeida Cars')
  end
end