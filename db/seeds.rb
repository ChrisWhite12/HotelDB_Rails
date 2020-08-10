# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new
user.email = "admin@email.com"
user.password = "rails1"
user.password_confirmation = "rails1"
user.admin = 3
user.save

for sell in 1..3
    p "seller - #{sell}"
    user = User.new
    user.email = "seller#{sell}@email.com"
    user.password = "rails1"
    user.password_confirmation = "rails1"
    user.admin = 2
    user.save

    for i in 1..6
        if i <= 2
            location = "Brisbane"
        elsif i > 2 && i <= 4
            location = "Sydney"
        else
            location = "Melbourne"
        end

        new_listing = Listing.create(name: "#{Faker::Address.city} Hotel", location: location, user_id: user.id)
        puts "created #{i} listings \n"
        
        for j in 1..2
            room_temp = Room.create(name: "Room 1#{(j.to_s).rjust(2,"0")}", price: 130, no_people: 1, aval: true, listing_id: new_listing.id)
            for k in 0..10
                Booking.create(date: (Date.parse('01/08/2020') + k), aval: true, room_id: room_temp[:id])
                
            end
        end
        for j in 1..4
            room_temp = Room.create(name: "Room 2#{(j.to_s).rjust(2,"0")}", price: 150, no_people: 2, aval: true, listing_id: new_listing.id)
            for k in 0..10
                Booking.create(date: (Date.parse('01/08/2020') + k), aval: true, room_id: room_temp[:id])
                
            end
        end
    end
end