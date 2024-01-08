require 'rails_helper'

RSpec.describe Destination, type: :model do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
  )
}
  it "should not create a destination without a country" do
    destination = Destination.create(
        city: 'San Juan',
        climate: 'Tropical',
        local_language: 'Spanish'
      )
      expect(destination.errors[:country]).to_not be_empty
  end
  it "should not create a destination without a city" do
    destination = Destination.create(
        country: 'Puerto Rico',
        climate: 'Tropical',
        local_language: 'Spanish'
      )
      expect(destination.errors[:city]).to_not be_empty
  end
  it "should not create a destination without a climate" do
    destination = Destination.create(
        country: 'Puerto Rico',
        city: 'San Juan',
        local_language: 'Spanish'
      )
      expect(destination.errors[:climate]).to_not be_empty
  end
  it "should not create a destination without a local language" do
    destination = Destination.create(
        country: 'Puerto Rico',
        city: 'San Juan',
        climate: 'Tropical'
      )
      expect(destination.errors[:local_language]).to_not be_empty
  end
end
