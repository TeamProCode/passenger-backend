require 'rails_helper'

RSpec.describe Destination, type: :model do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
}
  it "should not create a destination without a location" do
    destination = Destination.create(
        climate: 'Tropical',
        local_language: 'Spanish',
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.'
        )
      expect(destination.errors[:location]).to_not be_empty
  end

  it "should not create a destination without an image" do
    destination = Destination.create(
        location: 'Puerto Rico',
        climate: 'Tropical',
        local_language: 'Spanish',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.'
      )
      expect(destination.errors[:image]).to_not be_empty
  end
  it "should not create a destination without a climate" do
    destination = Destination.create(
        location: 'Puerto Rico',
        local_language: 'Spanish',
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.'
      )
      expect(destination.errors[:climate]).to_not be_empty
  end

  it "should not create a destination without a local language" do
    destination = Destination.create(
        location: 'Puerto Rico',
        climate: 'Tropical',
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
        description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.'
      )
      expect(destination.errors[:local_language]).to_not be_empty
  end

  it "should not create a destination without a description" do
    destination = Destination.create(
        location: 'Puerto Rico',
        local_language: 'Spanish',
        climate: 'Tropical',
        image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
      )
      expect(destination.errors[:description]).to_not be_empty
  end
end
