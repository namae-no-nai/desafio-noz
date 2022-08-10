# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::AuthorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/authors').to route_to('api/authors#index')
    end

    it 'routes to #show' do
      expect(get: '/api/authors/1').to route_to('api/authors#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/api/authors').to route_to('api/authors#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/authors/1').to route_to('api/authors#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/authors/1').to route_to('api/authors#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/authors/1').to route_to('api/authors#destroy', id: '1')
    end
  end
end
