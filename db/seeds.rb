# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create! do |u|
  u.email = 'sadmin1@test.com'
  u.password = 'password'
  u.name = 'sadmin1'
  u.superadmin_role = true
end
User.create! do |u|
  u.email = 'sadmin2@test.com'
  u.password = 'password'
  u.name = 'sadmin2'
  u.superadmin_role = true
end
User.create! do |u|
  u.email = 'admin1@test.com'
  u.password = 'password'
  u.name = 'admin1'
  u.supervisor_role = true
end
User.create! do |u|
  u.email = 'admin2@test.com'
  u.password = 'password'
  u.name = 'admin2'
  u.supervisor_role = true
end
User.create! do |u|
  u.email = 'user1@test.com'
  u.password = 'password'
  u.name = 'user1'
  u.user_role = true
end
User.create! do |u|
  u.email = 'user2@test.com'
  u.password = 'password'
  u.name = 'user2'
  u.user_role = true
end
