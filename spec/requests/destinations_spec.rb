require 'rails_helper'

RSpec.describe 'Destinations', type: :request do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
}

  describe 'GET /index' do
    it 'gets a list of destinations' do
      destination = user.destinations.create(
        country: 'Puerto Rico',
        city: 'San Juan',
        climate: 'Tropical',
        local_language: 'Spanish'
      )
      get '/destinations'

      destination = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(destination.first['country']).to eq('Puerto Rico')
    end
  end

  describe 'POST /create' do
    it 'creates a new destination' do
      destination_params = {
        destination: {
          country: 'Puerto Rico',
          city: 'San Juan',
          climate: 'Tropical',
          local_language: 'Spanish',
          user_id: user.id 
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status(200)
      destination = Destination.first
      expect(destination.country).to eq('Puerto Rico')
    end
  end

  describe 'PATCH /update' do
    it 'updates a destination' do
      destination_params = {
        destination: {
          country: 'Puerto Rico',
          city: 'San Juan',
          climate: 'Tropical',
          local_language: 'Spanish',
          user_id: user.id
        }
      }
      # create a destination with the above params
      post '/destinations', params: destination_params
      destination = Destination.last

      # supply updated params values
        destination_params_update = {
          destination: {
            country: 'Mexico',
            city: 'Tijuana',
            climate: 'Arid Sub-Tropical',
            local_language: 'Spanish',
            user_id: user.id 
          }
        }
      #update destination with updated params values
      patch "/destinations/#{destination.id}", params: destination_params_update

      expect(response).to have_http_status(200)
      destination = JSON.parse(response.body)
      destination = Destination.first
      expect(destination.country).to eq('Mexico')
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes a destination' do
      destination_params = {
        destination: {
          country: 'Mexico',
          city: 'Tijuana',
          climate: 'Arid Sub-Tropical',
          local_language: 'Spanish',
          user_id: user.id 
        }
      }
      post "/destinations", params: destination_params
      destination = Destination.first

      delete "/destinations/#{destination.id}"
      expect(response).to have_http_status(200)
    end
  end
end
