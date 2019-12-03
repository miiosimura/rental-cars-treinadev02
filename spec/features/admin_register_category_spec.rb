require 'rails_helper'

feature 'Admin register category' do
  scenario 'successfully' do
    visit root_path
    click_on 'Categorias'
    click_on 'Registrar nova categoria'

    fill_in 'Nome', with: 'Familiar'
    fill_in 'Diária', with: '100'
    fill_in 'Seguro do Carro', with: '50'
    fill_in 'Seguro contra Terceiros', with: '25'
    click_on 'Enviar'

    expect(page).to have_content('Familiar')
    expect(page).to have_content('100')
    expect(page).to have_content('50')
    expect(page).to have_content('25')
    expect(page).to have_link('Voltar')
  end
end