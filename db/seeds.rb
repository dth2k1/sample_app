# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: "Example User",
    email: "example@railstutorial.org",
    password: "foobar",
    password_confirmation: "foobar",
    admin: true,
    activated: true,
    activated_at: Time.zone.now)
    # Generate a bunch of additional users.
    # 99.times do |n|
    #     name = Faker::Name.name
    #     email = "example-#{n+1}@railstutorial.org"
    #     password = "password"
    #     User.create!(name: name,
    #     email: email,
    #     password: password,
    #     password_confirmation: password)
    # end
    99.times do |n|
     
        User.create!(name: "Example User #{n+1}",
            email: "example#{n+1}@railstutorial.org",
            password: "foobar",
            password_confirmation: "foobar",
            activated: true,
            activated_at: Time.zone.now) 
        end
        # users = User.order(:created_at).take(6)
        # 50.times do
        # content = Lorem.sentence(word_count: 5)
        # users.each { |user| user.microposts.create!(content: content) }
        # end
        users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
   #rails migrate reset to rết db
   # rails db:seed tao csdl khi chay trong file seed 