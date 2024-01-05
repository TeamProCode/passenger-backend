user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")

user1_destinations = [
  {
    country: 'Puerto Rico',
    city: 'San Juan',
    climate: 'Tropical',
    local_language: 'Spanish'
  },
  {
    country: 'Italy',
    city: 'Rome',
    climate: 'Mediterranean',
    local_language: 'Italian' 
  }
]
user2_destinations = [
  {
    country: 'Switzerland',
    city: 'Zurich',
    climate: 'Temperate',
    local_language: 'Swiss German'
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