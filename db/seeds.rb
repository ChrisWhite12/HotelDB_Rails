# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 1..10
    Listing.create(name: "#{Faker::Address.city} Hotel", location: Faker::Address.street_address)
    puts "created #{i} records \n"
    for j in 1..3
        Room.create(name: "Double Room", price: 150, no_people: 2, aval: true, listing_id: i)
    end
    for j in 1..3
        Room.create(name: "Single Room", price: 150, no_people: 1, aval: true, listing_id: i)
    end
end

pp Listing.all