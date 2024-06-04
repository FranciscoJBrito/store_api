require 'rails_helper'

RSpec.describe Token, type: :model do
  describe 'Validacion del modelo' do
    subject { build(:token) }
    it 'Validar si el token esta presente' do
      should validate_presence_of(:token)
    end
    it 'Validar si el expires_at esta presente' do
      should validate_presence_of(:expires_at)
    end
    it 'Valida si existe realcion con user' do
      should belong_to(:user)
    end
  end
end
