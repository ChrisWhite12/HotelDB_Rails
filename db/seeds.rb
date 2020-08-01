# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

for i in 1..4
    Listing.create(name: "#{Faker::Address.city} Hotel", location: Faker::Address.street_address)
    puts "created #{i} records \n"
    
    for j in 1..4
        room_temp = Room.create(name: "Room 1#{(j.to_s).rjust(2,"0")}", price: 150, no_people: 2, aval: true, listing_id: i)
        for k in 0..4
            Booking.create(date: (Date.parse('01/08/2020') + k), aval: true, room_id: room_temp[:id])
            
        end
    end
end

pp Listing.all