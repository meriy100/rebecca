# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!([{name: "test_user", email: "test@test.com", password: "testpass"}])
# Task.create!([
#   {user_id: 1, title: "テストタスク1", is_done: false, weight: 2, deadline_at: Time.zone.tomorrow},
#   {user_id: 1, title: "テストタスク2", is_done: false, weight: 3, deadline_at: Time.zone.tomorrow.tomorrow},
#   {user_id: 1, title: "テストタスク3", is_done: false, weight: 1, deadline_at: Time.zone.tomorrow.tomorrow.tomorrow},
#   {user_id: 1, title: "テストタスク4", is_done: false, weight: 1, deadline_at: Time.zone.tomorrow.tomorrow.tomorrow.tomorrow},
#   {user_id: 1, title: "テストタスク5", is_done: false, weight: 1, deadline_at: Time.zone.tomorrow.tomorrow.tomorrow.tomorrow.tomorrow},
# ])
