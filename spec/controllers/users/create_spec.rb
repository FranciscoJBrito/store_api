require 'rails_helper'
RSpec.describe V1::UsersController, type: :controller do
  describe 'Registro de usuario' do
    let(:user) { FactoryBot.create(:user) }

    context 'Usuario resgistrado correctamente' do
      before do
        post(:create, format: :json, params: { user: user })
      end
      context 'Respuesta con status created' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end
      context 'Respuesta con valores correctos de user' do
        subject { playload_test }
        it { is_expected.to include(:email, :age, :store, :token) }
      end
      context 'Respuesta con valores correctos de store' do
        subject { playload_test[:store] }
        it { is_expected.to include(:name, :created_at, :updated_at) }
      end
      context 'Respuesta con valores correctos de token' do
        subject { playload_test[:token] }
        it { is_expected.to include(:token, :expires_at) }
      end
    end

    let(:bad_user) { { email: 'test', password: '123456', age: 10 } }
    context 'Usuario incorrecto' do
      before do
        post(:create, format: :json, params: { user: bad_user })
      end
      context 'Respuesta con status bad request' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end
      context 'Respuesta con errores de validacion' do
        subject { playload_test }
        it { is_expected.to include(:errors) }
      end
    end
  end
end
