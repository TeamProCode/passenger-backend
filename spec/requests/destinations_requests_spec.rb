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
    it "does not create a destination without a location" do
      destination_params = {
        destination: {
          climate: 'Tropical',
          local_language: 'Spanish',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
          user_id: user.id
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['location']).to include "can't be blank"
    end

    it "does not create a destination without an image" do
      destination_params = {
        destination: {
          location: 'San Juan, Puerto Rico',
          climate: 'Tropical',
          local_language: 'Spanish',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
          user_id: user.id
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['image']).to include "can't be blank"
    end

    it "does not create a destination without a climate" do
      destination_params = {
        destination: {
          location: 'San Juan, Puerto Rico',
          local_language: 'Spanish',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
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
          location: 'San Juan, Puerto Rico',
          climate: 'Tropical',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
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
          location: 'San Juan, Puerto Rico',
          climate: 'Tropical',
          local_language: 'Spanish',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.'   
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['user_id']).to include "can't be blank"
    end
    it "does not create a destination without a description" do
      destination_params = {
        destination: {
          location: 'San Juan, Puerto Rico',
          climate: 'Tropical',
          local_language: 'Spanish',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          user_id: user.id
        }
      }
      post '/destinations', params: destination_params
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['description']).to include "can't be blank"
    end

  end

  describe "cannot update a destination without valid attributes"
    it "does not update a destination without a location" do
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
          climate: 'Tropical',
          local_language: 'Spanish',
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
          user_id: user.id
          }
      }
      patch "/destinations/#{destination.id}", params: destination_params_update
      expect(response).to have_http_status 422
      destination = JSON.parse(response.body)
      expect(destination['location']).to include "can't be blank"
  end
  
  it "does not update a destination without an image" do
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
        location: 'San Juan, Puerto Rico',
        climate: 'Tropical',
        local_language: 'Spanish',
        image: '',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
        user_id: user.id
      }
    }
    patch "/destinations/#{destination.id}", params: destination_params_update
    expect(response).to have_http_status 422
    destination = JSON.parse(response.body)
    expect(destination['image']).to include "can't be blank"
  end

  it "does not update a destination without a climate" do
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
        location: 'San Juan, Puerto Rico',
        climate: '',
        local_language: 'Spanish',
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
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
        location: 'San Juan, Puerto Rico',
        climate: 'Tropical',
        local_language: '',
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
        user_id: user.id
      }
    }
    patch "/destinations/#{destination.id}", params: destination_params_update
    expect(response).to have_http_status 422
    destination = JSON.parse(response.body)
    expect(destination['local_language']).to include "can't be blank"
  end

  it "does not update a destination without a description" do
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
        location: 'San Juan, Puerto Rico',
        climate: 'Tropical',
        local_language: 'Spanish',
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: '',    
        user_id: user.id
      }
    }
    patch "/destinations/#{destination.id}", params: destination_params_update
    expect(response).to have_http_status 422
    destination = JSON.parse(response.body)
    expect(destination['description']).to include "can't be blank"
  end
end
