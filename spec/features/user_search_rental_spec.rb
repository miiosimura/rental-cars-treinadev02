require 'rails_helper'

feature 'User search rental' do
  scenario 'successfully' do
    user = User.create!(email: 'teste@teste.com', password: '123456', role: :employee)
    client = Client.create!(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')
    category = Category.create!(name: 'A', daily_rate: 30, car_insurance: 30, third_party_insurance: 30)
    rental = Rental.create!(client: client, category: category, start_date: 1.day.from_now, end_date: 2.days.from_now, reservation_code: 'ABC1234', rental_status: :scheduled)
    other_rental = Rental.create!(client: client, category: category, start_date: 1.day.from_now, end_date: 2.days.from_now, reservation_code: 'AAA1234', rental_status: :scheduled)

    login_as user, scope: :user
    visit root_path
    click_on 'Locações'
    fill_in 'Código', with: rental.reservation_code
    click_on 'Buscar'

    expect(page).to have_content(rental.reservation_code)
    expect(page).not_to have_content(other_rental.reservation_code)
  end
end