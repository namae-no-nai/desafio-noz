require 'swagger_helper'

RSpec.describe 'api/users', type: :request do

  path '/api/login' do
    let(:created_user) { create(:user, password: '123456') }
    post('login user') do
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
      },
        required: %w[username password]
      }

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:user) { { username: created_user.username, password: '123456' } }
        run_test!
      end
    end
  end

  path '/api/users' do

    post('create user') do
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string },
        },
        required: %w[username password]
      }

      response(201, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:user) { { username: 'dummy', password: '123456' } }

        run_test!
      end
    end
  end
end
