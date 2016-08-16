FactoryGirl.define do
  factory :like do
    liker
    likeable_id 1

    trait :post_like do
      likeable_type "Post"
    end

    trait :comment_like do
      likeable_type "comment"
    end
  end

end