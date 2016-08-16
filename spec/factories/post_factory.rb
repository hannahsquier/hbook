FactoryGirl.define do
  factory :post, aliases: [:commentable] do
    author
    receiver
    body Faker::Lorem.paragraph
  end
end