require 'swagger_helper'

RSpec.describe 'Logins', type: :request do
  before do
    Login.create!(user: 'usuario', password: 'senha')
  end

  path '/logins' do
    post 'Realiza a autenticação de um usuário' do
      tags 'Autenticação'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :login, in: :body, schema: {
        type: :object,
        properties: {
          user: { type: :string },
          password: { type: :string }
        },
        required: %w[user password]
      }

      response '200', 'Usuário autenticado com sucesso' do
        let(:login) { { user: 'usuario', password: 'senha' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to have_key('token')
        end
      end

      response '401', 'Usuário não cadastrado' do
        let(:login) { { user: 'usuario_inexistente', password: 'senha' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['erro']).to eq('Usuário não cadastrado!')
        end
      end

      response '401', 'Credenciais inválidas' do
        let(:login) { { user: 'usuario', password: 'senha_errada' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['erro']).to eq('Usuário e Senha não coincidem!')
        end
      end
    end
  end
end