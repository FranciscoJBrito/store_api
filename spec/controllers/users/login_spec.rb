require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe 'Inicio de sesion del usuario' do
    let(:user) { FactoryBot.create(:user) }
    context 'Inicio de sesion correcto' do
      before do
        post(:login, format: :json, params: {
               user: {
                 email: user.email,
                 password: '123456'
               }
             })
      end
      context 'Estatus correcto (OK)' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end
      context 'Estructura de respuesta login correcta' do
        subject { playload_test }
        it { is_expected.to include(:email, :age, :store, :token) }
      end
      context 'Estructura de respuesta de token correcta' do
        subject { playload_test[:token] }
        it { is_expected.to include(:token, :expires_at) }
      end
    end
    context 'Inicio de sesión fallido' do
      before do
        post(:login, format: :json, params: {
               user: {
                 email: user.email,
                 password: ''
               }
             })
      end
      context 'Estatus correcto (bad_request)' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end
      context 'Estructura de login correcta' do
        subject { playload_test }
        it { is_expected.to include(:errors) }
      end
    end
  end
end
