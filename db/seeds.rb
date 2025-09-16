# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

# Reset the database (optional, but good for development)
Comment.destroy_all
Post.destroy_all
User.destroy_all

# Make results reproducible
Faker::Config.random = Random.new(42)

puts "🌱 Seeding users..."
users = 10.times.map do
  User.create!(
    username: Faker::Internet.unique.username(specifier: 3..12),
    email: Faker::Internet.unique.email,
    password: "password123"
  )
end
puts "✅ Created #{User.count} users"

puts "🌱 Seeding posts..."
posts = []
users.each do |user|
  3.times do
    posts << Post.create!(
      title: Faker::Book.title,
      content: Faker::Lorem.paragraph(sentence_count: 5),
      user: user
    )
  end
end
puts "✅ Created #{Post.count} posts"

puts "🌱 Seeding comments..."
posts.each do |post|
  rand(2..5).times do
    Comment.create!(
      content: Faker::Lorem.sentence(word_count: 10),
      user: users.sample,
      post: post
    )
  end
end
puts "✅ Created #{Comment.count} comments"

puts "🌱 Done seeding!"
