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

    book1 = Booking.create(date: '27/07/2020', aval: true)
    book2 = Booking.create(date: '28/07/2020', aval: true)
    book3 = Booking.create(date: '29/07/2020', aval: true)    
    book4 = Booking.create(date: '30/07/2020', aval: true)

    for j in 1..3
        Room.create(name: "Room 2#{(j.to_s).rjust(2,"0")}", price: 150, no_people: 2, aval: true, listing_id: i, booking_id: book1[:id])
        Room.create(name: "Room 2#{(j.to_s).rjust(2,"0")}", price: 150, no_people: 2, aval: true, listing_id: i, booking_id: book2[:id])
    end
    for j in 1..3
        Room.create(name: "Room 1#{(j.to_s).rjust(2,"0")}", price: 150, no_people: 1, aval: true, listing_id: i, booking_id: book3[:id])
        Room.create(name: "Room 1#{(j.to_s).rjust(2,"0")}", price: 150, no_people: 1, aval: true, listing_id: i, booking_id: book4[:id])
    end
end

pp Listing.all