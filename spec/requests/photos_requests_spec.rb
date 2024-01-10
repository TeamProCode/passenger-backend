require 'rails_helper'

RSpec.describe "Photos", type: :request do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
}
  let(:destination) {Destination.create(
    location: 'San Juan, Puerto Rico',
    climate: 'Tropical',
    local_language: 'Spanish',
    image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
    description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
    user_id: user.id
  )
}
# Create a user and a destination within describe block to use for all below tests

  describe 'GET /index' do
    it 'gets a list of photos' do
      photo = destination.photos.create(
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
        destination_id: destination.id
      )
      get '/photos'

      photo = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(photo.first['image']).to eq('https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900')
    end
  end

  describe 'POST /create' do
    it 'creates a photo' do
      photo_params = {
        photo: {
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'scenery',
          destination_id: destination.id 
        }
      }
      post '/photos', params: photo_params
      expect(response).to have_http_status(200)
      photo = Photo.first
      expect(photo.image).to eq('https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900')
    end
  end

  describe 'PATCH /update' do
    it 'updates a photo' do
      user.destinations.create(
        location: 'San Juan, Puerto Rico',
        climate: 'Tropical',
        local_language: 'Spanish',
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
        user_id: user.id
      )
      destination = user.destinations.first
      photo_params = {
        photo: {
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'scenery',
          destination_id: destination.id 
        }
      }
      post '/photos', params: photo_params
      photo = Photo.last
        photo_params_update = {
          photo: {
            image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
            description: 'Switzerland',
            destination_id: destination.id 
            }
        }
      patch "/photos/#{photo.id}", params: photo_params_update

      expect(response).to have_http_status(200)
      photo = JSON.parse(response.body)
      photo = Photo.first
      expect(photo.description).to eq('Switzerland')
    end
  end

  describe 'DELETE /destroy' do
    it 'deletes a photo' do
      photo_params = {
        photo: {
          image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
          description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',    
          destination_id: destination.id
        }
      }
      post "/photos", params: photo_params
      photo = Photo.first
      delete "/photos/#{photo.id}"
      expect(response).to have_http_status(200)
    end
  end
end
