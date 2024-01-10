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
        location: 'San Juan, Puerto Rico',
        climate: 'Tropical',
        local_language: 'Spanish',
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
        user_id: user.id
      )
      get '/destinations'

      destination = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(destination.first['location']).to eq('San Juan, Puerto Rico')
    end
  end

  describe 'POST /create' do
    it 'creates a new destination' do
      destination_params = {
        destination: {
          location: 'San Juan, Puerto Rico',
          climate: 'Tropical',
          local_language: 'Spanish',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
          user_id: user.id
          }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status(200)
      destination = Destination.first
      expect(destination.location).to eq('San Juan, Puerto Rico')
    end
  end

  describe 'PATCH /update' do
    it 'updates a destination' do
      destination_params = {
        destination: {
          location: 'San Juan, Puerto Rico',
          climate: 'Tropical',
          local_language: 'Spanish',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
          user_id: user.id
          }
      }
      # create a destination with the above params
      post '/destinations', params: destination_params
      destination = Destination.last

      # supply updated params values
        destination_params_update = {
          destination: {
            location: 'San Juan, Puerto Rico',
            climate: 'Arid Sub-Tropical',
            local_language: 'Spanish',
            image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
            description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',      
            user_id: user.id 
          }
        }
      #update destination with updated params values
      patch "/destinations/#{destination.id}", params: destination_params_update

      expect(response).to have_http_status(200)
      destination = JSON.parse(response.body)
      destination = Destination.first
      expect(destination.climate).to eq('Arid Sub-Tropical')
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes a destination' do
      destination_params = {
        destination: {
          location: 'San Juan, Puerto Rico',
          climate: 'Tropical',
          local_language: 'Spanish',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
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
    it "does not create a destination without a location, climate, local language, image and description" do
      destination_params = {
        destination: {
          user_id: user.id
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['location']).to include "can't be blank"
      expect(destination['climate']).to include "can't be blank"
      expect(destination['local_language']).to include "can't be blank"
      expect(destination['image']).to include "can't be blank"
      expect(destination['description']).to include "can't be blank"
    end
  end

  describe "cannot update a destination without valid attributes"
    it "does not update a destination without a location, climate, local language, image and description" do
      destination_params = {
        destination: {
          location: 'San Juan, Puerto Rico',
          climate: 'Tropical',
          local_language: 'Spanish',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
          user_id: user.id
          }
      }
      post '/destinations', params: destination_params
      destination = Destination.first

      destination_params_update = {
        destination: {
          location: '',
          climate: '',
          local_language: '',
          image: '',
          description: '',    
          user_id: user.id
          }
      }
      patch "/destinations/#{destination.id}", params: destination_params_update
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['location']).to include "can't be blank"
      expect(destination['climate']).to include "can't be blank"
      expect(destination['local_language']).to include "can't be blank"
      expect(destination['image']).to include "can't be blank"
      expect(destination['description']).to include "can't be blank"
  end
end
