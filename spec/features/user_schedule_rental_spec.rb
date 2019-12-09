require 'rails_helper'

feature 'User schedule rental' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456', role: :employee)
    client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
    category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)

    login_as(user, scope: :user)
    visit root_path
    click_on 'Locações'
    click_on 'Agendar Locação'
    fill_in 'Data de Inicio', with: '09/12/2019'
    fill_in 'Data de Encerramento', with: '12/12/2019'
    select "#{client.name} - #{client.cpf}", from: 'Cliente'
    select category.name, from: 'Categoria do Carro'
    click_on 'Agendar'

    expect(page).to have_content('Locação agendada com sucesso!')
    expect(page).to have_content('Data de Inicio: 09/12/2019')
    expect(page).to have_content('Data de Encerramento: 12/12/2019')
    expect(page).to have_content('Cliente:')
    expect(page).to have_content(client.name)
    expect(page).to have_content('CPF:')
    expect(page).to have_content(client.cpf)
    expect(page).to have_content('Categoria do Carro: ')
    expect(page).to have_content(category.name)
  end

  #scenario 'and must fill all fields' do
  #end

  #scenario 'and start date must be less to end date' do
  #end
end