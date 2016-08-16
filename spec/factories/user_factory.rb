FactoryGirl.define do
  factory :user, aliases: [:author, :receiver, :liker] do
    sequence(:first_name) { |n| "Foo#{n}" }
    sequence(:last_name) { |n| "Bar#{n}" }
    password "password"
    email { "#{first_name}.#{last_name}@gmail.com".downcase }

    birthday (Time.now - 20.years)
    gender ('other')
     after(:build) do |user|
       user.generate_auth_token
     end
  end
end