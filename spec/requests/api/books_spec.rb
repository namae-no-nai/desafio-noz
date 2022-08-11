# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/books', type: :request do
  let(:user) { create(:user) }
  let(:'Authorization') { "Bearer #{JWT.encode({ user_id: user.id }, 'secret')}" }

  path '/api/books' do
    get('list books') do
      response(200, 'successful') do
        security [Bearer: {}]

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

    post('create book') do
      response(201, 'successful') do
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :book, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            description: { type: :string },
            author_id: { type: :integer },
            genre: { type: :string },
            published_at: { type: :integer },
            publisher: { type: :string }
          },
          required: %w[title description author_id genre published_at publisher]
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:user) { author.user }
        let(:author) { create(:author) }
        let(:book) do
          {
            title: 'Romeo and Juliet',
            description: 'A tragic romance',
            author_id: author.id,
            genre: 'Romance',
            published_at: Date.today,
            publisher: 'Britanica'
          }
        end
        run_test!
      end
    end
  end

  path '/api/books/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show book') do
      response(200, 'successful') do
        security [Bearer: {}]

        before do
          create(:book, id: '123')
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

    put('update book') do
      response(200, 'successful') do
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: 'id', in: :path, type: :string, description: 'id'
        parameter name: :book, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            description: { type: :string },
            author_id: { type: :integer },
            genre: { type: :string },
            published_at: { type: :integer },
            publisher: { type: :string }
          },
          required: %w[title description author_id genre published_at publisher]
        }

        before do
          create(:book, id: '123')
        end

        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let(:user) { author.user }
        let(:author) { create(:author) }
        let(:book) do
          {
            title: 'Romeo and Juliet',
            description: 'A tragic romance',
            author_id: author.id,
            genre: 'Romance',
            published_at: Date.today,
            publisher: 'Britanica'
          }
        end
        run_test!
      end
    end

    delete('delete book') do
      response(204, 'successful') do
        security [Bearer: {}]

        before do
          create(:book, id: '123')
        end

        let(:id) { '123' }

        run_test!
      end
    end
  end
end
