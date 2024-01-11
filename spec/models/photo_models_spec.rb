require 'rails_helper'

RSpec.describe Photo, type: :model do
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

  it "should not create a photo without an image" do
    photo = destination.photos.create(
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.',
        destination_id: destination.id
        )
      expect(photo.errors[:image]).to_not be_empty
  end

  it "should not create a photo without a description" do
    photo = destination.photos.create(
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        destination_id: destination.id
        )
      expect(photo.errors[:description]).to_not be_empty
  end

  it "should not create a photo without a description of at least 8 characters" do
    photo = destination.photos.create(
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: 'invalid',
        destination_id: destination.id
        )
      expect(photo.errors[:description]).to_not be_empty
  end
end
