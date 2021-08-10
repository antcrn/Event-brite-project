# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.destroy_all
User.reset_pk_sequence
Event.destroy_all
Event.reset_pk_sequence
Attendance.destroy_all
Attendance.reset_pk_sequence

10.times do
  user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description:Faker::Lorem.sentence(word_count: 10), email: Faker::Internet.email, password:"123456", password_confirmation:"123456")
end

30.times do 
  event = Event.create(title:Faker::Lorem.sentence(word_count: 3),description: Faker::Lorem.sentence(word_count: 50),location: Faker::Address.city,price: rand(1..1000),start_date:Faker::Date.between(from: '2021-08-11', to: '2024-09-25'),duration:[5,10,15,20,25,30,35,45,50,55,60].sample,administrator_id:rand(1..10))  
end

20.times do
  attendant = Attendance.create(user_id:rand(1..10), event_id:rand(1..30), stripe_customer_id: Faker::Lorem.sentence(word_count: 3))
end