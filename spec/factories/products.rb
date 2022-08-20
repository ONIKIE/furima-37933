FactoryBot.define do
  factory :product do
    association :user
    name { Faker::Commerce.product_name }
    explanation { Faker::Lorem.characters(20) }
    category_id { Faker::Number.within(range: 2..11) }
    shipping_fee_id { Faker::Number.within(range: 2..3) }
    status_id { Faker::Number.within(range: 2..7) }
    prefecture_id { Faker::Number.within(range: 2..48) }
    day_id { Faker::Number.within(range: 2..4) }
    price { Faker::Number.within(range: 300..9_999_999) }
  end
end
