require 'swagger_helper'

RSpec.describe 'api/authors', type: :request do

  path '/api/authors' do

    get('list authors') do
      response(200, 'successful') do

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
        required: [ 'name', 'main_genre', 'age' ]
      }
      response(201, 'successful') do

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
        
        before do 
          create(:author, id: '123') 
        end

        let(:id) { '123' }

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
        parameter name: 'id', in: :path, type: :string, description: 'id'
        parameter name: :author, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            main_genre: { type: :string },
            age: { type: :integer }
          },
          required: [ 'name', 'main_genre', 'age' ]
        }

        before do 
          create(:author, id: '123') 
        end

        let(:id) { '123' }

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

    delete('delete author') do
      response(204, 'successful') do
        parameter name: 'id', in: :path, type: :string, description: 'id'
        
        before do 
          create(:author, id: '123') 
        end
        
        let(:id) { '123' }

        run_test!
      end
    end
  end
end
