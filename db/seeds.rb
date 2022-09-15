# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "clearing the DB"
BanHammer.destroy_all
Game.destroy_all
User.destroy_all
puts "DB clean"

puts "creating user"
user1 = User.create(user_name: "Mario", picture: "https://pbs.twimg.com/profile_images/680494684121227264/_lxrAkG4.jpg", password: "123456", email: "mario@test.com", left_color: "red", right_color: "blue")
puts "creating #{user1.email} "
user2 = User.create(user_name: "Samus", picture: "https://ih0.redbubble.net/image.12420732.1173/pp,550x550.jpg", password: "123456", email: "samus@test.com", left_color: "orange", right_color: "purple")
puts "creating #{user2.email} "
user3 = User.create(user_name: "Zelda", picture: "https://i.pinimg.com/originals/3a/3c/a8/3a3ca8ff96875931e9df6bde326aeeb5.png", password: "123456", email: "zelda@test.com", left_color: "pink", right_color: "green")
puts "creating #{user3.email} "
user4 = User.create(user_name: "Link", picture: "https://www.geekalerts.com/u/The-Legend-of-Zelda-Wind-Waker-Link-Nendoroid-Figure.jpg", password: "123456", email: "link@test.com", left_color: "green", right_color: "turquoise")
puts "creating #{user4.email} "
