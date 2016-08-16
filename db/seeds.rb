# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Post.destroy_all
Like.destroy_all
Friending.destroy_all
Comment.destroy_all
Profile.destroy_all

User.create(email: "hannah@gmail.com", password: "password")

MULTIPLIER = 10

MULTIPLIER.times do

  User.create(email: Faker::Internet.email,
              first_name: Faker:: Name.first_name,
              last_name: Faker:: Name.last_name,
              password: "password",
              birthday: Faker::Date.between(100.years.ago, 10.years.ago),
              gender: ["other", "female", "male", nil].sample
    )
end

User.all.each do |u|

  u.profile.update(college: Faker::University.name,
                    city: Faker::Address.city,
                    state: Faker::Address.state,
                    country: Faker::Address.country,
                    phone: Faker::PhoneNumber.cell_phone,
                    words_to_live_by: Faker::Hipster.sentence(2),
                    about_me: Faker::Hipster.paragraph(2))

  (3..10).to_a.sample.times do
    u.posts << Post.new(body: Faker::Hipster.paragraph,
                              receiver_id: User.pluck(:id).sample)
  end



  (2..8).to_a.sample.times do |n|


    Friending.create(friender_id: u.id, friended_id:  User.pluck(:id).sample  )

  end
end

Post.all.each do |p|
  (0..4).to_a.sample.times do
    p.comments << Comment.new(body: Faker::Hipster.paragraph, user_id: User.pluck(:id).sample)
  end

  (0..10).to_a.sample.times do
    p.likes << Like.new(liker_id: User.pluck(:id).sample)
  end

end


