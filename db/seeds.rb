# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Destroying all cards..."
Card.destroy_all
puts "All cards destroyed!"

puts "Creating cards..."
Card.create!(number: 0, specialty: "none", image_url: "app/assets/images/cards/CABO-0.jpeg")
Card.create!(number: 1, specialty: "none", image_url: "app/assets/images/cards/CABO-1.jpeg")
Card.create!(number: 2, specialty: "none", image_url: "app/assets/images/cards/CABO-2.jpeg")
Card.create!(number: 3, specialty: "none", image_url: "app/assets/images/cards/CABO-3.jpeg")
Card.create!(number: 4, specialty: "none", image_url: "app/assets/images/cards/CABO-4.jpeg")
Card.create!(number: 5, specialty: "none", image_url: "app/assets/images/cards/CABO-5.jpeg")
Card.create!(number: 6, specialty: "none", image_url: "app/assets/images/cards/CABO-6.jpeg")
Card.create!(number: 7, specialty: "peek", image_url: "app/assets/images/cards/CABO-7.jpeg")
Card.create!(number: 8, specialty: "peek", image_url: "app/assets/images/cards/CABO-8.jpeg")
Card.create!(number: 9, specialty: "spy", image_url: "app/assets/images/cards/CABO-9.jpeg")
Card.create!(number: 10, specialty: "spy", image_url: "app/assets/images/cards/CABO-10.jpeg")
Card.create!(number: 11, specialty: "swap", image_url: "app/assets/images/cards/CABO-11.jpeg")
Card.create!(number: 12, specialty: "swap", image_url: "app/assets/images/cards/CABO-12.jpeg")
Card.create!(number: 13, specialty: "none", image_url: "app/assets/images/cards/CABO-13.jpeg")
puts "Cards created!"
