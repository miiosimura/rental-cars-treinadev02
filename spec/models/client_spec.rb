require 'rails_helper'

describe Client do
  describe '.description' do
    it 'must return name with document' do
      client = Client.new(name: 'Fulano', email: 'fulano@email.com', cpf: '503.682.450-47')

      expect(client.description).to eq 'Fulano - 503.682.450-47'
    end

    it ''
  end
end
