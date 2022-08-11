# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/authors', type: :request do
  let(:user) { create(:user) }
  let(:'Authorization') { "Bearer #{JWT.encode({ user_id: user.id }, 'secret')}" }

  path '/api/authors' do
    get('list authors') do
      response(200, 'successful') do
        security [Bearer: {}]
        parameter name: :name, in: :query, type: :string, required: false
        parameter name: :main_genre, in: :query, type: :string, required: false
        parameter name: :age, in: :query, type: :integer, required: false

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create author') do
      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          main_genre: { type: :string },
          age: { type: :integer }
        },
        required: %w[name main_genre age]
      }

      response(201, 'successful') do
        security [Bearer: {}]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:author) { { name: 'Shakespere', main_genre: 'Romance', age: 34 } }
        run_test!
      end
    end
  end

  path '/api/authors/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show author') do
      response(200, 'successful') do
        security [Bearer: {}]

        let(:author) { create(:author) }
        let(:user) { author.user }
        let(:id) { author.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    put('update author') do
      response(200, 'successful') do
        consumes 'application/json'
        security [Bearer: {}]
        
        parameter name: 'id', in: :path, type: :string, description: 'id'
        parameter name: :author, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            main_genre: { type: :string },
            age: { type: :integer }
          },
          required: %w[name main_genre age]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        before do
          create(:author, id: 123, user: user)
        end

        let(:id) { 123 }

        let(:author) { { name: 'Shakespere', main_genre: 'Romance', age: 34 } }
        run_test!
      end
    end

    delete('delete author') do
      response(204, 'successful') do
        parameter name: 'id', in: :path, type: :string, description: 'id'
        security [Bearer: {}]

        let(:author) { create(:author) }
        let(:user) { author.user }
        let(:id) { author.id }

        run_test!
      end
    end
  end
end
