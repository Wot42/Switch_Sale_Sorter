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
user1 = User.create(user_name: "Mario", picture: "https://pbs.twimg.com/profile_images/680494684121227264/_lxrAkG4.jpg", password: "123456", email: "test1@test.com")
user2 = User.create(user_name: "Samus", picture: "https://ih0.redbubble.net/image.12420732.1173/pp,550x550.jpg", password: "123456", email: "test2@test.com")
user3 = User.create(user_name: "Zelda", picture: "https://i.pinimg.com/originals/3a/3c/a8/3a3ca8ff96875931e9df6bde326aeeb5.png", password: "123456", email: "test3@test.com")
puts "creating #{user1.email} "
puts "creating #{user2.email} "
puts "creating #{user3.email} "

puts "creating Games"
game1 = Game.create(title: "#1 Crosswords Bundle", price: 5.49, sale_price: 1.37, genre: "Puzzle", pic: "https://fs-prod-cdn.nintendo-europe.com/media/images/10_share_images/games_15/nintendo_switch_download_software_1/H2x1_NSwitchDS_1CrosswordsBundle_image1600w.jpg", api_id: "/Games/Nintendo-Switch-download-software/-1-Anagrams-1965260.html")

puts "creating #{game1.title} "

puts "games created #{Game.all.length}"
