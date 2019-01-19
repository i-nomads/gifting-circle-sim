# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

circle = Circle.create!(name: "First Circle", round: 1)

User.create!(name: "Da Winner", circle: circle, round: 1, level: 1, balance: 0)

2.times do
  User.create!(
    circle: circle,
    round: 1,
    level: 2,
    balance: 0
  )
end

4.times do
  User.create!(
    circle: circle,
    round: 1,
    level: 3,
    balance: 0
  )
end
