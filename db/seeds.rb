# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do 
  User.create(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: Faker::Internet.email, password: "test1111", password_confirmation: "test1111")
  Teacher.create(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: Faker::Internet.email, password: "test1111", password_confirmation: "test1111")
end

  User.create(firstname: "admin", lastname: "Won", email: "master@tinytalk.com", password: "mastertinytalk", password_confirmation: "mastertinytalk")

  Teacher.create(firstname: "admin", lastname: "Won", email: "master@tinytalk.com", password: "mastertinytalk", password_confirmation: "mastertinytalk")


 Course.create(category: "Online", course_type: "Intermediate", introduction: "asdf", count_students: 1, started_at: "2017-05-16", ended_at: "2017-06-13", location: nil, days: "[\"Tue\", \"Wed\"]", total_classes: 8, course_hour: "1h", german_time: "09:00", room_session: nil, room_session_id: nil, korean_time: "16:00", state: nil, teacher_id: 11)

c = Course.last
u = User.last
c.users << u
c.save
