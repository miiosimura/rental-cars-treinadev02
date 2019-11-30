require 'rails_helper'

feature 'Admin viewer subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')

    visit root_path
    click_on 'Filiais'
    click_on 'Almeida Cars'
    
    expect(page).to have_content('Almeida Cars')
    expect(page).to have_content('00.000.000-00')
    expect(page).to have_content('Alameda Santos, 1293')
  end

  scenario 'and view subsidiaries links' do
    Subsidiary.create!(name: 'Almeida Cars', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')
    Subsidiary.create!(name: 'R1', cnpj: '00.000.000-00', address: 'Alameda Santos, 1293')

    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_link('Almeida Cars')
    expect(page).to have_link('R1')
  end
  
  scenario 'and no subsidiary exists' do
    visit root_path
    click_on 'Filiais'
    
    expect(page).to have_content('Não existem filiais cadastradas no sistema')
  end
end