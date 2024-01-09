user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")

user1_destinations = [
  {
    location: 'San Juan, Puerto Rico',
    climate: 'Tropical',
    local_language: 'Spanish',
    image: 'https://static.nationalgeographic.co.uk/files/styles/image_3200/public/online_ean749_hr_web_0.jpg?w=1600&h=900',
    description: 'Vibrant Caribbean city with rich culture, history, and colorful architecture.'
  },
  {
    location: 'Rome, Italy',
    climate: 'Mediterranean',
    local_language: 'Italian',
    image: 'https://www.travelandleisure.com/thmb/QDUywna6SQbiQte-ZmrJmXcywp0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/rome-italy-lead-ROMETG0521-7bd455d3c2b545219498215df7143e0d.jpg',
    description: 'Historic city with ancient ruins, art, and vibrant Italian culture.'
  }
]
user2_destinations = [
  {
    location: 'Zurich, Switzerland',
    climate: 'Temperate',
    local_language: 'Swiss German',
    image: 'https://live.staticflickr.com/505/31895270053_5028581a32_b.jpg',
    description: 'Alpine whimsy meets urban flair, chocolate delights, pristine lakes, and cultural sophistication abound.'
    }
]

user1_destinations.each do |destination|
  user1.destinations.create destination
  puts "creating destination #{destination}"
end

user2_destinations.each do |destination|
    user2.destinations.create destination
    puts "creating destination #{destination}"
end