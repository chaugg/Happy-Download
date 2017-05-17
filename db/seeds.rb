# Users
User.create! name: "Example User",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  admin: true,
  created_at: Time.zone.now

10.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@gmail.org"
  password = "password"
  User.create! name: name,
    email: email,
    password: password,
    password_confirmation: password,
    created_at: Time.zone.now
end

5.times do
  name = Faker::Name.name
  Category.create! name: name,
    created_at: Time.zone.now
end

users = User.all
categories = Category.all
users[1..5].each do |user|
  categories[1..4].each do |category|
    5.times do
      instrument = Faker::Music.instrument
      Product.create! user_id: user.id,
        category_id: category.id,
        created_at: Time.zone.now,
        title: instrument
    end
  end
end
