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

  describe "cannot create a destination without valid attributes" do
    it "does not create a destination without a country" do
      destination_params = {
        destination: {
          city: 'San Juan',
          climate: 'Tropical',
          local_language: 'Spanish',
          user_id: user.id
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['country']).to include "can't be blank"
    end

    it "does not create a destination without a city" do
      destination_params = {
        destination: {
          country: 'Puerto Rico',
          climate: 'Tropical',
          local_language: 'Spanish',
          user_id: user.id
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['city']).to include "can't be blank"
    end

    it "does not create a destination without a climate" do
      destination_params = {
        destination: {
          country: 'Puerto Rico',
          city: 'San Juan',
          local_language: 'Spanish',
          user_id: user.id
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['climate']).to include "can't be blank"
    end

    it "does not create a destination without a local language" do
      destination_params = {
        destination: {
          country: 'Puerto Rico',
          city: 'San Juan',
          climate: 'Tropical',
          user_id: user.id
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['local_language']).to include "can't be blank"
    end

    it "does not create a destination without a user" do
      destination_params = {
        destination: {
          country: 'Puerto Rico',
          city: 'San Juan',
          climate: 'Tropical',
          local_language: 'Spanish'
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['user_id']).to include "can't be blank"
    end
  end

  describe "cannot update a destination without valid attributes"
    it "does not update a destination without a country" do
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
      destination = Destination.first

      destination_params_update = {
        destination: {
          country: '',
          city: 'San Juan',
          climate: 'Tropical',
          local_language: 'Spanish',
          user_id: user.id
        }
      }
      patch "/destinations/#{destination.id}", params: destination_params_update
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['country']).to include "can't be blank"
  end
  
  it "does not update a destination without a city" do
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
    destination = Destination.first

    destination_params_update = {
      destination: {
        country: 'Puerto Rico',
        city: '',
        climate: 'Tropical',
        local_language: 'Spanish',
        user_id: user.id
      }
    }
    patch "/destinations/#{destination.id}", params: destination_params_update
    expect(response).to have_http_status 422
    destination = JSON.parse(response.body)
    expect(destination['city']).to include "can't be blank"
  end

  it "does not update a destination without a climate" do
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
    destination = Destination.first

    destination_params_update = {
      destination: {
        country: 'Puerto Rico',
        city: 'San Juan',
        climate: '',
        local_language: 'Spanish',
        user_id: user.id
      }
    }
    patch "/destinations/#{destination.id}", params: destination_params_update
    expect(response).to have_http_status 422
    destination = JSON.parse(response.body)
    expect(destination['climate']).to include "can't be blank"
  end
  it "does not update a destination without a local language" do
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
    destination = Destination.first

    destination_params_update = {
      destination: {
        country: 'Puerto Rico',
        city: 'San Juan',
        climate: 'Tropical',
        local_language: '',
        user_id: user.id
      }
    }
    patch "/destinations/#{destination.id}", params: destination_params_update
    expect(response).to have_http_status 422
    destination = JSON.parse(response.body)
    expect(destination['local_language']).to include "can't be blank"
  end
  it "does not update a destination without a user id" do
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
    destination = Destination.first

    destination_params_update = {
      destination: {
        country: 'Puerto Rico',
        city: 'San Juan',
        climate: 'Tropical',
        local_language: 'Spanish',
        user_id: ''
      }
    }
    patch "/destinations/#{destination.id}", params: destination_params_update
    expect(response).to have_http_status 422
    destination = JSON.parse(response.body)
    expect(destination['user_id']).to include "can't be blank"
  end
end
