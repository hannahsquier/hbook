FactoryGirl.define do
  factory :comment do
    author

    commentable
    body Faker::Lorem.paragraph

    trait :post_comment do
      commentable_type "Post"
    end

  end
end