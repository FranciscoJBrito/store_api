require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validaciones del producto' do
    subject { build(:product) } 
    it 'Validar si existe store id' do
      should validate_presence_of(:store_id)
    end
    it 'Validar si name existe' do 
      should validate_presence_of(:name)
    end
    it 'Validar si description existe' do 
      should validate_presence_of(:description)
    end
    it 'Validar si price existe' do 
      should validate_presence_of(:price)
    end
    it 'Validar asociación hacia la tienda' do
      should belong_to(:store)
    end
  end
end
